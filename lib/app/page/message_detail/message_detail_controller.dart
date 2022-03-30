import 'dart:async';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/interfaces/message_service_type.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageDetailController extends GetxController {
  MessageDetailController({required this.user});
  final User user;
  late TextEditingController sendController;
  RxBool isLoading = false.obs;
  final _messageService = Get.find<MessageServiceType>();
  final _authService = Get.find<AuthServiceType>();
  final _sessionManager = Get.find<SessionManager>();

  late StreamSubscription<List<Message>> streamSubcriptionSender;
  late StreamSubscription<List<Message>> streamSubcriptionReceiver;

  RxList<Message> listMessages = <Message>[].obs;

  RxList<Message> listMessagesUI = <Message>[].obs;

  User currentUser =
      User(userId: 'userId', email: 'email', name: '', token: '');

  Future<void> sendMessage() async {
    if (sendController.text.isNotEmpty) {
      try {
        var result = await _messageService.sendMessage(
          message: Message(
            message: sendController.text,
            sender: currentUser.email,
            receiver: user.email,
            sendTime:
                DateFormat('yyyy/MM/dd \- kk:mm:ss').format(DateTime.now()),
          ),
        );
        sendController.clear();
      } catch (e) {
        ErrorHandler.current.handle(error: e);
      }
    }
  }

  Stream<List<Message>> getLastMessageSender(
      {required String sender, required String receiver}) {
    var listMessages = _messageService.listenMessagesFromSender(
        sender: sender, receiver: receiver);
    print(listMessages.length);
    return listMessages;
  }

  Stream<List<Message>> getLastMessageReceiver(
      {required String sender, required String receiver}) {
    var listMessages = _messageService.listenMessagesFromReceiver(
        sender: sender, receiver: receiver);
    print(listMessages.length);
    return listMessages;
  }

  Future<void> getCurrentUser() async {
    try {
      currentUser = await _sessionManager.currentUser();
    } catch (e) {
      ErrorHandler.current.handle(error: e);
    }
  }

  @override
  void onInit() async {
    sendController = TextEditingController();
    await getCurrentUser();

    streamSubcriptionSender =
        getLastMessageSender(receiver: user.email, sender: currentUser.email)
            .listen((event) {
      listMessages.addAll(event);

      listMessages.sort((a, b) => b.sendTime.compareTo(a.sendTime));
    });
    streamSubcriptionReceiver =
        getLastMessageReceiver(sender: user.email, receiver: currentUser.email)
            .listen((event) {
      listMessages.addAll(event);

      listMessages.sort((a, b) => b.sendTime.compareTo(a.sendTime));
    });
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
  }

  @override
  void onClose() {
    streamSubcriptionSender.cancel();
    streamSubcriptionReceiver.cancel();
    super.onClose();
  }
}

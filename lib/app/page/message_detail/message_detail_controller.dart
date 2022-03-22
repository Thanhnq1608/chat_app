import 'dart:async';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/interfaces/message_service_type.dart';
import 'package:chat_app/data/core/auth.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/core/models/user.dart' as local;
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MessageDetailController extends GetxController {
  MessageDetailController({required this.user});
  final local.User user;
  late TextEditingController sendController;
  DateTime now = DateTime.now();
  RxBool isLoading = false.obs;
  final _messageService = Get.find<MessageServiceType>();
  final _authService = Get.find<AuthServiceType>();
  final _sessionManager = Get.find<SessionManager>();

  late StreamSubscription<List<Message>> streamSubcription;

  RxList<Message> listMessages = <Message>[].obs;

  User currentUser = User(userId: 'userId', email: 'email');

  Future<void> sendMessage() async {
    if (sendController.text.isNotEmpty) {
      try {
        var result = await _messageService.sendMessage(
          message: Message(
            message: sendController.text,
            sender: currentUser.email,
            receiver: 'receiver',
            sendTime: DateFormat('yyyy/MM/dd \- kk:mm:ss').format(now),
          ),
        );
        sendController.clear();
      } catch (e) {
        ErrorHandler.current.handle(error: e);
      }
    }
  }

  // Future<void> getMessages() async {
  //   try {
  //     isLoading(true);
  //     listMessages.addAll(await _messageService.getListMessage());
  //     isLoading(false);
  //   } catch (e) {
  //     ErrorHandler.current.handle(error: e);
  //   }
  // }

  Stream<List<Message>> getLastMessage() {
    var listMessages = _messageService.listenMessagesUpdate();
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
  void onInit() {
    sendController = TextEditingController();
    streamSubcription = getLastMessage().listen((event) {
      listMessages.addAll(event);
    });
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await getCurrentUser();
  }

  @override
  void onClose() {
    streamSubcription.cancel();
    super.onClose();
  }
}

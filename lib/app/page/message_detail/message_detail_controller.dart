import 'dart:async';

import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/data/models/user.dart' as userModel;
import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/interfaces/message_service_type.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/data/core/auth.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MessageDetailController extends GetxController {
  MessageDetailController({required this.user});
  final User user;
  late TextEditingController sendController;
  RxBool isLoading = false.obs;
  final _messageService = Get.find<MessageServiceType>();
  final _authService = Get.find<AuthServiceType>();

  late StreamSubscription<List<Message>> streamSubcription;

  RxList<Message> listMessages = <Message>[].obs;

  userModel.User currentUser = userModel.User(userId: 'userId', email: 'email');

  Future<void> sendMessage() async {
    if (sendController.text.isNotEmpty) {
      try {
        var result = await _messageService.sendMessage(
            message: sendController.text, email: currentUser.email);
        sendController.clear();
      } catch (e) {
        ErrorHandler.current.handle(error: e);
      }
    }
  }

  Future<void> getMessages() async {
    try {
      isLoading(true);
      listMessages.addAll(await _messageService.getListMessage());
      isLoading(false);
    } catch (e) {
      ErrorHandler.current.handle(error: e);
    }
  }

  Stream<List<Message>> getLastMessage() {
    var listMessages = _messageService.listenMessagesUpdate();
    print(listMessages.length);
    return listMessages;
  }

  Future<void> getCurrentUser() async {
    try {
      currentUser = await _authService.getCurrentUser();
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
    await getMessages();
  }

  @override
  void onClose() {
    streamSubcription.cancel();
    super.onClose();
  }
}

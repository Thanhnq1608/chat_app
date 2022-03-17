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
  final _messageService = Get.find<MessageServiceType>();
  final _authService = Get.find<AuthServiceType>();
  userModel.User currentUser = userModel.User(userId: 'userId', email: 'email');

  Future<void> sendMessage() async {
    if (sendController.text.isNotEmpty) {
      try {
        var result = await _messageService.sendMessage(
            message: sendController.text, email: currentUser.email);
        await _messageService.getMessages();
      } catch (e) {
        ErrorHandler.current.handle(error: e);
      }
    }
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
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await getCurrentUser();
  }
}

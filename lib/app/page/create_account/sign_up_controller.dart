import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passController;
  late TextEditingController rePassController;

  var isLoading = false.obs;
  final _authService = Get.find<AuthServiceType>();

  @override
  void onInit() {
    emailController = TextEditingController();
    passController = TextEditingController();
    rePassController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.clear();
    passController.clear();
    rePassController.clear();
    super.onClose();
  }

  Future<bool> signUp() async {
    if (emailController.text.isEmpty ||
        passController.text.isEmpty ||
        rePassController.text.isEmpty) {
      ErrorHandler.current.handle(error: 'You can\'t left empty data');

      return false;
    } else if (passController.text.compareTo(rePassController.text) != 0) {
      ErrorHandler.current.handle(error: 'Incorrect password repeat');
      return false;
    } else {
      try {
        isLoading.value = true;
        final result = await _authService.signUpWithEmailAndPassword(
          email: emailController.text,
          password: passController.text,
        );
        await _authService.createUser(
            user: User(userId: result.userId, email: result.email));
        isLoading.value = false;
        return true;
      } catch (e) {
        ErrorHandler.current.handle(error: e);
        isLoading.value = false;
        return false;
      }
    }
  }
}

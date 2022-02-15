import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passController;
  late TextEditingController rePassController;

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
}

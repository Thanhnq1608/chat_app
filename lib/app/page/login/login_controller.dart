import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordContoller;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordContoller = TextEditingController();
    super.onInit();
  }
}

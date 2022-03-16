import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController passwordContoller;
  final _authService = Get.find<AuthServiceType>();
  var isLoading = false.obs;

  @override
  void onInit() {
    emailController = TextEditingController();
    passwordContoller = TextEditingController();
    super.onInit();
  }

  Future<void> login({required String email, required String password}) async {
    try {
      isLoading.value = true;
      final result = await _authService.signInWithEmailAndPassword(
          email: email, password: password);
      isLoading.value = false;
      Get.offAllNamed(AppRoutes.HOME);
    } catch (e) {
      ErrorHandler.current.handle(error: e);
      isLoading.value = false;
      rethrow;
    }
  }
}

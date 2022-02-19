import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  late TextEditingController emailController;
  late TextEditingController rePassController;
  late TextEditingController passController;
  final _authService = Get.find<AuthServiceType>();
  var isLoading = false.obs;
  var isClickReset = false.obs;

  @override
  void onInit() {
    emailController = TextEditingController();
    rePassController = TextEditingController();
    passController = TextEditingController();
    super.onInit();
  }

  @override
  void onClose() {
    emailController.clear();
    rePassController.clear();
    passController.clear();
    super.onClose();
  }

  Future<void> forgotPassword({required String email}) async {
    try {
      isLoading.value = true;
      final result = await _authService.resetPassword(email: email);
      isLoading.value = false;
      isClickReset.value = true;
      await 2.delay();
      isClickReset.value = false;
      Get.offNamed(AppRoutes.LOGIN);
      print(result);
    } catch (e) {
      ErrorHandler.current.handle(error: e);
      isLoading.value = false;
      rethrow;
    }
  }
}

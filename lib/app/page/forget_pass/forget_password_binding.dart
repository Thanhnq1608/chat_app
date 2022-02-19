import 'package:chat_app/app/page/forget_pass/forget_password_controller.dart';
import 'package:get/get.dart';

class ForgetPasswordBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(ForgetPasswordController());
  }
}

import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/page/login/login_controller.dart';
import 'package:chat_app/data/services/auth_service.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(LoginController());
  }
}

import 'package:chat_app/app/page/create_account/sign_up_controller.dart';
import 'package:get/get.dart';

class SignUpBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SignUpController());
  }
}

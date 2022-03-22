import 'package:chat_app/app/page/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashBindings extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.put(SplashController());
  }
}

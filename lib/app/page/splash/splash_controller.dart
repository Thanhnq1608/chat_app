import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final _sessionManager = Get.find<SessionManager>();

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    final bool isLogin = await _sessionManager.isLogin();
    if (!isLogin) {
      Get.offNamed(AppRoutes.LOGIN);
    } else {
      print(await _sessionManager.currentUser());
      Get.offNamed(AppRoutes.HOME);
    }
  }
}

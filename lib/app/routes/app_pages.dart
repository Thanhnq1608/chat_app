import 'package:chat_app/app/page/create_account/sign_up_binding.dart';
import 'package:chat_app/app/page/create_account/sign_up_screen.dart';
import 'package:chat_app/app/page/forget_pass/forget_password_binding.dart';
import 'package:chat_app/app/page/forget_pass/forget_password_screen.dart';
import 'package:chat_app/app/page/home/home_binding.dart';
import 'package:chat_app/app/page/home/home_screen.dart';
import 'package:chat_app/app/page/login/login_binding.dart';
import 'package:chat_app/app/page/login/login_screen.dart';
import 'package:chat_app/app/page/message_detail/message_detail_screen.dart';
import 'package:chat_app/app/page/splash/splash_bindings.dart';
import 'package:chat_app/app/page/splash/splash_screen.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final INITIAL = AppRoutes.SPLASH;

  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashBindings(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.MESSAGE,
      page: () => MessageDetailScreen(),
    ),
    GetPage(
      name: AppRoutes.LOGIN,
      page: () => LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.SIGN_UP,
      page: () => SignUpScreen(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: AppRoutes.FORGET_PASS,
      page: () => ForgetPasswordScreen(),
      binding: ForgetPasswordBinding(),
    ),
  ];
}

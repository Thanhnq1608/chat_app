import 'package:chat_app/app/page/home/home_screen.dart';
import 'package:chat_app/app/page/splash/splash_screen.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static final INITIAL = AppRoutes.HOME;

  static final pages = [
    GetPage(
      name: AppRoutes.SPLASH,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: AppRoutes.HOME,
      page: () => HomeScreen(),
    ),
  ];
}

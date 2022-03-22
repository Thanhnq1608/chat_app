import 'package:chat_app/app/app_bindings.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/data/api/shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(const MyApp());
}

Future<void> initServices() async {
  print('starting services ...');
  final app = await Firebase.initializeApp();
  print("firebase app name: ${app.name}");

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  await Get.putAsync(() => SfStorage().intial());
  // final pushNotificationManager = PushNotificationManager();
  // await pushNotificationManager.configure();
  // Get.put(pushNotificationManager);

  // print('All services started...');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      defaultTransition: Transition.rightToLeft,
      theme: AppTheme.dark,
      debugShowCheckedModeBanner: false,
      getPages: AppPages.pages,
      initialRoute: AppPages.INITIAL,
      initialBinding: AppBindings(),
    );
  }
}

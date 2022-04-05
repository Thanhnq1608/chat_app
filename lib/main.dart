import 'dart:io';

import 'package:chat_app/app/app_bindings.dart';
import 'package:chat_app/app/routes/app_pages.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/core/app_theme.dart';
import 'package:chat_app/data/api/shared_preferences/shared_preferences.dart';
import 'package:chat_app/data/models/notification_data.dart';
import 'package:chat_app/tools/helper/show_local_push_notification.dart';
import 'package:chat_app/tools/push_notification/push_notification.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TestWidgetsFlutterBinding.ensureInitialized();
  await initServices();

  runApp(const MyApp());
}

Future<void> initServices() async {
  print('starting services ...');

  final app = await Firebase.initializeApp();
  await Get.putAsync(() => SfStorage().intial());
  final pushNotificationManager = PushNotification();
  await pushNotificationManager.configure();
  Get.put(pushNotificationManager);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  print("firebase app name: ${app.name}");

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.

  print('All services started...');
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  await ShowLocalPushNotification(
          flutterLocalNotificationsPlugin: flutterLocalNotificationsPlugin)
      .showLocalPushNotification(message);
  print("Handling a background message: ${message.messageId}");
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

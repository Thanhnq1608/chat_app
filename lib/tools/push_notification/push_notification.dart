import 'dart:async';
import 'dart:io';

import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/data/api/shared_preferences/shared_preferences.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification extends GetxService {
  final _sfStorage = Get.find<SfStorage>();
  final _firestore = FirebaseFirestore.instance;
  late FirebaseMessaging messaging;

  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  RxBool hasNotification = RxBool(false);

  Timer? _checkHasNotificationTimer;

  final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  void _handleClickNotify() {
    final sessionManager = Get.find<SessionManager>();
    sessionManager.isLogin().then((isLogin) {
      if (isLogin) {
        // Get.toNamed(AppRoutes.NOTIFICATION_LIST);
      }
    });
  }

  Future<void> configure() async {
    messaging = FirebaseMessaging.instance;
    await _initFlutterNotificationsPlugin();
    // await _requestiOSPermissionIfNeed();
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      _handleClickNotify();
    });

    final user = await _sfStorage.getCurrentUser();

    String? tokenLocal = await _sfStorage.getTokenFirebase();
    String? tokenFirebase = await messaging.getToken();

    if (tokenLocal == null || tokenLocal != tokenFirebase) {
      //update token firebase in local
      _sfStorage.setTokenFirebase(tokenFirebase);
      print(await _sfStorage.getTokenFirebase());
    }

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      //Reload Notification Badge
      final _sessionManager = Get.find<SessionManager>();
      _sessionManager.isLogin().then((isLogin) {
        _showLocalPushNotification(message);
      });
    });
  }

  Future<void> _showLocalPushNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    if (notification == null) {
      return;
    }

    //Show local notification for android
    if (Platform.isAndroid) {
      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channel.id,
        channel.name,
        color: Colors.black,
        playSound: true,
        icon: '@drawable/launch_background',
      );

      var platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      flutterLocalNotificationsPlugin.show(notification.hashCode,
          notification.title, notification.body, platformChannelSpecifics,
          payload: message.data.toString());
    }
    //Show local notification for iOS
    if (Platform.isIOS) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode, notification.title, notification.body, null,
          payload: message.data.toString());
    }
  }

  Future<void> _initFlutterNotificationsPlugin() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/launch_background');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) {
      _handleClickNotify();
    });
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    print("Handling a background message: ${message.messageId}");
  }
}

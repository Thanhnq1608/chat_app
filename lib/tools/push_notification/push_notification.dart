import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:chat_app/app/components/collection_name_firestore.dart';
import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/data/api/shared_preferences/shared_preferences.dart';
import 'package:chat_app/data/models/notification_data.dart';
import 'package:chat_app/data/models/notification.dart' as localNoti;
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/data/services/auth_service.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:chat_app/tools/helper/show_local_push_notification.dart';
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

  Future<void> _handleClickNotify({required String email}) async {
    final sessionManager = Get.find<SessionManager>();

    final _authService = Get.find<AuthServiceType>();
    var userDoc = await _firestore
        .collection(CollectionNameFirestore.getName(type: CollectionType.users))
        .doc(email)
        .get();
    if (userDoc.data() == null) {
      return;
    }
    var user = User.fromJson(userDoc.data()!);
    sessionManager.isLogin().then((isLogin) {
      if (isLogin) {
        Get.toNamed(AppRoutes.MESSAGE, arguments: user);
      }
    });
  }

  Future<void> configure() async {
    messaging = FirebaseMessaging.instance;
    await _initFlutterNotificationsPlugin();
    // await _requestiOSPermissionIfNeed();
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      print('You clicked to notìication onMessageOpenedApp');
      // Get.toNamed(AppRoutes.MESSAGE,
      //     arguments: await _sfStorage.getCurrentUser());

      var data = localNoti.Notification.fromJson(event.data);

      await _handleClickNotify(email: data.data.sender);
    });

    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

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

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      var user = await _sfStorage.getIsInMessage();
      String userSentNotification =
          NotificationData.fromJson(message.data).sender;

      if (user == null || user.compareTo(userSentNotification) != 0) {
        print('Got a message whilst in the foreground!');
        print('Message data ${user}: ${message.data}');
        await ShowLocalPushNotification(
                flutterLocalNotificationsPlugin:
                    flutterLocalNotificationsPlugin)
            .showLocalPushNotification(message);
      }
    });
  }

  Future<void> _initFlutterNotificationsPlugin() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_ta_chat_app');
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
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        await _handleClickNotify(email: payload!);
        print(payload);
      },
    );
  }
}

import 'dart:io';

import 'package:chat_app/data/models/notification_data.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class ShowLocalPushNotification {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  ShowLocalPushNotification({required this.flutterLocalNotificationsPlugin});

  final AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    importance: Importance.max,
  );

  Future<void> showLocalPushNotification(RemoteMessage message) async {
    NotificationData data = NotificationData.fromJson(message.data);
    print(Platform.isAndroid);
    if (Platform.isAndroid) {
      final androidPlatformChannelSpecifics = AndroidNotificationDetails(
        channel.id,
        channel.name,
        color: Colors.white,
        playSound: true,
        icon: '@drawable/ic_ta_chat_app',
      );

      var platformChannelSpecifics =
          NotificationDetails(android: androidPlatformChannelSpecifics);

      flutterLocalNotificationsPlugin.show(
          data.hashCode, data.title, data.message, platformChannelSpecifics,
          payload: message.data['sender'].toString());
    }
    //Show local notification for iOS
    if (Platform.isIOS) {
      flutterLocalNotificationsPlugin.show(
          data.hashCode, data.title, data.message, null,
          payload: message.data.toString());
    }
  }
}

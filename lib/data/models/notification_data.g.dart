// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationData _$NotificationDataFromJson(Map<String, dynamic> json) =>
    NotificationData(
      title: json['title'] as String,
      message: json['body'] as String,
      clickAction: json['click_action'] as String?,
      sender: json['sender'] as String,
    );

Map<String, dynamic> _$NotificationDataToJson(NotificationData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'body': instance.message,
      'click_action': instance.clickAction,
      'sender': instance.sender,
    };

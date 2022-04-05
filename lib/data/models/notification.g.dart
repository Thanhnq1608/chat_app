// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Notification _$NotificationFromJson(Map<String, dynamic> json) => Notification(
      data: NotificationData.fromJson(json['data'] as Map<String, dynamic>),
      priority: json['priority'] as String,
      receiver: json['to'] as String,
    );

Map<String, dynamic> _$NotificationToJson(Notification instance) =>
    <String, dynamic>{
      'to': instance.receiver,
      'data': instance.data,
      'priority': instance.priority,
    };

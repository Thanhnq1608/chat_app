// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recent_contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecentContact _$RecentContactFromJson(Map<String, dynamic> json) =>
    RecentContact(
      isSeen: json['is_seen'] as bool,
      lastMessage: json['last_message'] as String,
      sendTime: json['send_time'] as String,
      email: json['email'] as String,
      sender: json['sender'] as String,
      name: json['user_name'] as String,
    );

Map<String, dynamic> _$RecentContactToJson(RecentContact instance) =>
    <String, dynamic>{
      'is_seen': instance.isSeen,
      'last_message': instance.lastMessage,
      'user_name': instance.name,
      'email': instance.email,
      'send_time': instance.sendTime,
      'sender': instance.sender,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      message: json['message'] as String,
      type: json['type'] as int,
      sendTime: json['send_time'] as String,
      receiver: json['receiver'] as String,
      sender: json['sender'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'message': instance.message,
      'send_time': instance.sendTime,
      'type': instance.type,
      'sender': instance.sender,
      'receiver': instance.receiver,
    };

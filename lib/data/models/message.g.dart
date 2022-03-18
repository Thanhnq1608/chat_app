// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      message: json['text'] as String,
      sender: json['sender'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'sender': instance.sender,
      'text': instance.message,
    };

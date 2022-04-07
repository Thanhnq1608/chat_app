import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String message;

  @JsonKey(name: 'send_time')
  String sendTime;

  int type;

  String sender;

  String receiver;

  Message({
    required this.message,
    required this.type,
    required this.sendTime,
    required this.receiver,
    required this.sender,
  });

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

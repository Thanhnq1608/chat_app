import 'package:json_annotation/json_annotation.dart';

part 'message.g.dart';

@JsonSerializable()
class Message {
  String sender;

  @JsonKey(name: 'text')
  String message;

  @JsonKey(name: 'send_time')
  String sendTime;

  String receiver;

  Message(
      {required this.message,
      required this.sender,
      required this.receiver,
      required this.sendTime});

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

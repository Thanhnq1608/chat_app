import 'package:chat_app/data/models/notification_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification.g.dart';

@JsonSerializable()
class Notification {
  @JsonKey(name: 'to')
  final String receiver;

  final NotificationData data;

  final String priority;

  Notification(
      {required this.data, required this.priority, required this.receiver});

  factory Notification.fromJson(Map<String, dynamic> json) =>
      _$NotificationFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationToJson(this);
}

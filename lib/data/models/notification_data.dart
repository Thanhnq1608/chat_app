import 'package:json_annotation/json_annotation.dart';

part 'notification_data.g.dart';

@JsonSerializable()
class NotificationData {
  final String title;

  @JsonKey(name: 'body')
  final String message;

  @JsonKey(name: 'click_action')
  final String? clickAction;

  final String sender;

  NotificationData(
      {required this.title,
      required this.message,
      this.clickAction,
      required this.sender});

  factory NotificationData.fromJson(Map<String, dynamic> json) =>
      _$NotificationDataFromJson(json);
  Map<String, dynamic> toJson() => _$NotificationDataToJson(this);
}

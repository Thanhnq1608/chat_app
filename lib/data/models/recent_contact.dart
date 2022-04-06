import 'package:json_annotation/json_annotation.dart';

part 'recent_contact.g.dart';

@JsonSerializable()
class RecentContact {
  @JsonKey(name: 'is_seen')
  final bool isSeen;

  @JsonKey(name: 'last_message')
  final String lastMessage;

  @JsonKey(name: 'user_name')
  final String name;

  final String email;

  @JsonKey(name: 'send_time')
  final String sendTime;

  RecentContact(
      {required this.isSeen,
      required this.lastMessage,
      required this.sendTime,
      required this.email,
      required this.name});

  factory RecentContact.fromJson(Map<String, dynamic> json) =>
      _$RecentContactFromJson(json);
  Map<String, dynamic> toJson() => _$RecentContactToJson(this);
}

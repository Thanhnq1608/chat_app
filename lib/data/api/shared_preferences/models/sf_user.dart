import 'package:json_annotation/json_annotation.dart';

part 'sf_user.g.dart';

@JsonSerializable()
class SfUser {
  String userId;
  String email;
  String name;

  SfUser({required this.userId, required this.email, required this.name});

  factory SfUser.fromJson(Map<String, dynamic> json) => _$SfUserFromJson(json);
  Map<String, dynamic> toJson() => _$SfUserToJson(this);
}

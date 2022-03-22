import 'package:json_annotation/json_annotation.dart';

part 'sf_user.g.dart';

@JsonSerializable()
class SfUser {
  String userId;
  String email;

  SfUser({required this.userId, required this.email});

  factory SfUser.fromJson(Map<String, dynamic> json) => _$SfUserFromJson(json);
  Map<String, dynamic> toJson() => _$SfUserToJson(this);
}

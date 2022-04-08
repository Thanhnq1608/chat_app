import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  @JsonKey(name: 'user_id')
  String userId;

  String? avatar;

  String email;

  String name;

  String token;

  User(
      {required this.userId,
      required this.email,
      this.avatar,
      required this.name,
      required this.token});

  User clone() {
    return User(userId: userId, email: email, name: name, token: token);
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

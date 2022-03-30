import 'package:json_annotation/json_annotation.dart';

part 'sf_token_firebase.g.dart';

@JsonSerializable()
class SfTokenFirebase {
  String token;

  SfTokenFirebase({required this.token});

  factory SfTokenFirebase.fromJson(Map<String, dynamic> json) =>
      _$SfTokenFirebaseFromJson(json);
  Map<String, dynamic> toJson() => _$SfTokenFirebaseToJson(this);
}

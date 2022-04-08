import 'dart:convert';

import 'package:chat_app/data/api/shared_preferences/models/sf_token_firebase.dart';
import 'package:chat_app/data/api/shared_preferences/models/sf_user.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum SfKeys { userProfile, tokenFirebase }

class SfStorage extends GetxService {
  late SharedPreferences _spf;

  Future<SfStorage> intial() async {
    _spf = await SharedPreferences.getInstance();
    return this;
  }

  Future<void> setUserProfile(User? user) async {
    if (user == null) {
      await _spf.remove(_getRawKey(SfKeys.userProfile));
      return;
    }

    final sfUser = SfUser(
        userId: user.userId,
        email: user.email,
        name: user.name,
        avatar: user.avatar);

    await _spf.setString(
      _getRawKey(SfKeys.userProfile),
      json.encode(
        sfUser.toJson(),
      ),
    );
  }

  Future<void> setTokenFirebase(String? token) async {
    if (token == null || token.isEmpty) {
      await _spf.remove(_getRawKey(SfKeys.tokenFirebase));
      return;
    }
    final sfTokenFirebase = SfTokenFirebase(token: token);
    await _spf.setString(
      _getRawKey(SfKeys.tokenFirebase),
      json.encode(
        sfTokenFirebase.toJson(),
      ),
    );
  }

  Future<String?> getTokenFirebase() async {
    String? sfTokenFirebase = _spf.getString(_getRawKey(SfKeys.tokenFirebase));

    if (sfTokenFirebase == null || sfTokenFirebase.isEmpty) {
      return null;
    }

    SfTokenFirebase sfToken =
        SfTokenFirebase.fromJson(json.decode(sfTokenFirebase));

    return sfToken.token;
  }

  Future<User?> getCurrentUser() async {
    String? sfAccountStr = _spf.getString(_getRawKey(SfKeys.userProfile));
    String? sfToken = _spf.getString(_getRawKey(SfKeys.tokenFirebase));

    if (sfAccountStr == null ||
        sfAccountStr.isEmpty ||
        sfToken == null ||
        sfToken.isEmpty) {
      return null;
    }

    SfUser sfUser = SfUser.fromJson(json.decode(sfAccountStr));
    SfTokenFirebase sfTokenFirebase =
        SfTokenFirebase.fromJson(json.decode(sfToken));

    final currentUser = User(
        userId: sfUser.userId,
        email: sfUser.email,
        name: sfUser.name,
        avatar: sfUser.avatar,
        token: sfTokenFirebase.token);

    return currentUser;
  }

  String _getRawKey(SfKeys storageKey) {
    switch (storageKey) {
      case SfKeys.userProfile:
        return 'user_profile';
      case SfKeys.tokenFirebase:
        return 'token_firebase';
    }
  }
}

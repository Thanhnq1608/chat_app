import 'dart:convert';

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

    final sfUser = SfUser(userId: user.userId, email: user.email);

    await _spf.setString(
      _getRawKey(SfKeys.userProfile),
      json.encode(
        sfUser.toJson(),
      ),
    );
  }

  Future<User?> getCurrentUser() async {
    String? sfAccountStr = _spf.getString(_getRawKey(SfKeys.userProfile));

    if (sfAccountStr == null || sfAccountStr.isEmpty) {
      return null;
    }

    SfUser sfUser = SfUser.fromJson(json.decode(sfAccountStr));

    final currentUser = User(userId: sfUser.userId, email: sfUser.email);

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

import 'package:chat_app/data/api/shared_preferences/shared_preferences.dart';
import 'package:chat_app/data/services/auth_service.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:get/get.dart';

class SessionManager extends GetxService {
  final SfStorage sfStorage;

  SessionManager({required this.sfStorage});

  Future<bool> isLogin() async {
    try {
      await currentUser();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<User> currentUser() async {
    final user = await sfStorage.getCurrentUser();
    if (user == null) {
      throw ErrorHandler();
    }
    return user;
  }

  Future<void> updateProfile(User user) async {
    await sfStorage.setUserProfile(user);
  }

  Future<String?> currentTokenFirebase() async {
    final token = await sfStorage.getTokenFirebase();
    return token;
  }

  Future<void> updateTokenFirebase(String token) async {
    await sfStorage.setTokenFirebase(token);
  }

  Future<void> logout() async {
    await sfStorage.setUserProfile(null);
  }
}

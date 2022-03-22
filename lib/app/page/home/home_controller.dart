import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _sessionManager = Get.find<SessionManager>();
  final _authService = Get.find<AuthServiceType>();
  late final TextEditingController searchController;

  Future<void> logout() async {
    try {
      await _sessionManager.logout();
      await _authService.signOut();
      Get.offAllNamed(AppRoutes.LOGIN);
    } catch (e) {
      ErrorHandler.current.handle(error: e);
    }
  }

  Future<void> loadProfile() async {
    try {
      final userProfile = await _authService.getCurrentUser();
      // user(userProfile);
      _sessionManager.updateProfile(userProfile);
    } catch (e) {
      ErrorHandler.current.handle(error: e);
    }
  }

  @override
  void onInit() {
    searchController = TextEditingController();
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await loadProfile();
  }
}

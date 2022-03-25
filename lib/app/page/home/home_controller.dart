import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final _sessionManager = Get.find<SessionManager>();
  final _authService = Get.find<AuthServiceType>();
  final TextEditingController searchController = TextEditingController();

  RxBool isLoading = false.obs;
  // late StreamSubscription<List<User>> streamSubscription;

  RxList<User> users = RxList<User>();

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
      _sessionManager.updateProfile(userProfile);
    } catch (e) {
      ErrorHandler.current.handle(error: e);
    }
  }

  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    await loadProfile();
    searchController.addListener(() async {
      if (searchController.text != "" || searchController.text.isNotEmpty) {
        isLoading(true);
        users.value =
            await _authService.getUserByEmail(email: searchController.text);
        isLoading(false);
        print(users.value.length);
      } else {
        users.value.clear();
      }
    });
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}

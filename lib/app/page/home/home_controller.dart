import 'dart:async';
import 'dart:io';

import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/app/interfaces/recent_contact_service_type.dart';
import 'package:chat_app/app/interfaces/upload_image_service_type.dart';
import 'package:chat_app/app/routes/app_routes.dart';
import 'package:chat_app/data/models/recent_contact.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/data/services/recent_contact_service.dart';
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:chat_app/tools/push_notification/push_notification.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class HomeController extends GetxController {
  final _sessionManager = Get.find<SessionManager>();
  final _authService = Get.find<AuthServiceType>();
  final _recentContactService = Get.find<RecentContactServiceType>();
  final _pushNotification = Get.find<PushNotification>();
  final _uploadImageService = Get.find<UploadImageServiceType>();
  final TextEditingController searchController = TextEditingController();

  File? image;

  RxBool isLoading = false.obs;
  RxBool isLoadingAvatar = false.obs;
  late StreamSubscription<List<RecentContact>> streamSubscription;

  RxList<User> users = RxList<User>();
  RxList<User> usersSearch = RxList<User>();
  RxList<RecentContact> recentContacts = RxList<RecentContact>();

  Rx<User> currentUser = User(
    userId: "userId",
    email: "email",
    name: "name",
    token: "token",
  ).obs;

  Future<void> logout() async {
    try {
      await _authService.signOut();
      Get.offAllNamed(AppRoutes.LOGIN);
    } catch (e) {
      ErrorHandler.current.handle(error: e);
    }
  }

  Future<void> seenMessage({required RecentContact contact}) async {
    try {
      await _recentContactService.seenMessage(contact: contact);
    } catch (e) {
      ErrorHandler.current.handle(error: e);
    }
  }

  Future<void> loadProfile() async {
    try {
      final userProfile = await _authService.getCurrentUser();
      print(userProfile.email);
      users.value = await _authService.getUsersByName();
      await _sessionManager.updateProfile(userProfile);
      _authService.updateTokenUser(email: userProfile.email);
      print(userProfile.email);
    } catch (e) {
      ErrorHandler.current.handle(error: e);
    }
  }

  Future<void> chooseFile() async {
    await ImagePicker.platform
        .pickImage(source: ImageSource.gallery)
        .then((image) {
      if (image != null) {
        this.image = File(image.path);
        print(image.path);
      }
    });
  }

  Future<void> uploadAvatar({required File imageFile}) async {
    try {
      isLoadingAvatar(true);
      var avatar = await _uploadImageService.uploadImageToFirebaseStorage(
          image: imageFile);
      var newUser = currentUser.value.clone()..avatar = avatar;
      currentUser.value = newUser;
      _uploadImageService.updateAvatarUser(avatar: currentUser.value.avatar!);
      _sessionManager.updateProfile(currentUser.value);
      isLoadingAvatar(false);
    } catch (e) {
      ErrorHandler.current.handle(error: e);
    }
  }

  Future<Stream<List<RecentContact>>> recentContact() async {
    var contacts = await _recentContactService.recentContact();
    print(contacts.length);
    return contacts;
  }

  Future<User> getUser({required String email}) async {
    try {
      var users = await _authService.getUserByEmail(email: email);
      return users;
    } catch (e) {
      ErrorHandler.current.handle(error: e);
      rethrow;
    }
  }

  @override
  void onInit() async {
    await loadProfile().then((value) async {
      listenWhileClickNotifyWhenAppOff();
      currentUser.value = await _sessionManager.currentUser();
    });
    var recent = await recentContact();
    streamSubscription = recent.listen((event) {
      recentContacts.value = event;

      recentContacts.sort((a, b) => b.sendTime.compareTo(a.sendTime));
    });
    super.onInit();
  }

  @override
  void onReady() async {
    // TODO: implement onReady
    super.onReady();
    searchController.addListener(() async {
      if (searchController.text == "" || searchController.text.isEmpty) {
        usersSearch.value.clear();
        usersSearch.refresh();
      } else {
        isLoading(true);
        usersSearch.value = users.value
            .where((user) => user.name.contains(searchController.text))
            .toList();
        isLoading(false);
        print(users.value.length);
      }
    });
  }

  Future<void> listenWhileClickNotifyWhenAppOff() async {
    var message = await FirebaseMessaging.instance.getInitialMessage();
    if (message == null) {
      // ErrorHandler.current.handle(error: 'null r???i');
      return;
    }
    var user = User.fromJson(message.data);
    ErrorHandler.current.handle(error: user.email);
    Get.toNamed(AppRoutes.MESSAGE, arguments: user);
  }

  @override
  void onClose() {
    searchController.dispose();
    streamSubscription.cancel();
    super.onClose();
  }
}

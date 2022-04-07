import 'dart:async';
import 'dart:convert';

import 'package:chat_app/app/components/collection_name_firestore.dart';
import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/data/models/notification.dart';
import 'package:chat_app/data/models/recent_contact.dart';
import 'package:chat_app/data/models/user.dart' as userModel;
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AuthService extends GetxService implements AuthServiceType {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  final _sessionManager = Get.find<SessionManager>();
  final client = http.Client();

  Rx<bool> isVerifyEmail = false.obs;
  Timer? timer;

  userModel.User? _userFromFirebaseUser({userModel.User? user}) {
    return user != null
        ? userModel.User(
            userId: user.userId,
            email: user.email,
            name: user.name,
            token: user.token)
        : null;
  }

  @override
  Future<userModel.User> getCurrentUser() async {
    final userLocal = await _auth.currentUser;
    final docUser = await _firestore
        .collection(CollectionNameFirestore.getName(type: CollectionType.users))
        .doc(userLocal!.email)
        .get();
    final user = docUser.data();
    return _userFromFirebaseUser(user: userModel.User.fromJson(user!))!;
  }

  @override
  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    final token = await _sessionManager.currentTokenFirebase();
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? userCredential = result.user;
    final docUser = await _firestore
        .collection(CollectionNameFirestore.getName(type: CollectionType.users))
        .doc(userCredential!.email)
        .get();
    final user = docUser.data();

    print('Result: $result');
    return _userFromFirebaseUser(
      user: userModel.User.fromJson(user!),
    );
  }

  @override
  Future<userModel.User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    User? user = result.user;

    print('Result: $result');
    return userModel.User(
        email: user!.email!, userId: user.uid, name: '', token: '');
  }

  @override
  Future resetPassword({required String email}) async {
    final result = await _auth.sendPasswordResetEmail(email: email);
    return result;
  }

  @override
  Future signOut() async {
    final user = await _sessionManager.currentUser();
    print(user.email);
    _firestore
        .collection(CollectionNameFirestore.getName(type: CollectionType.users))
        .doc(user.email)
        .update({'token': ''});
    _sessionManager.logout();
    timer?.cancel();
    return await _auth.signOut();
  }

  @override
  Future<bool> changePassword({required String email}) async {
    isVerifyEmail(_auth.currentUser!.emailVerified);

    if (!isVerifyEmail.value) {
      _sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 1), (_) {
        checkEmailVerified();
      });
    }

    return isVerifyEmail.value;
  }

  Future checkEmailVerified() async {
    await _auth.currentUser!.reload();

    isVerifyEmail.value = _auth.currentUser!.emailVerified;

    if (isVerifyEmail.value) {
      timer?.cancel();
    }
  }

  Future _sendVerificationEmail() async {
    final user = _auth.currentUser!;
    await user.sendEmailVerification();
  }

  @override
  Future<void> createUser({required userModel.User user}) async {
    var addUser = userModel.User(
        email: user.email,
        userId: user.userId,
        name: user.name,
        token: user.token);
    Map<String, dynamic> userMap = user.toJson();

    //save user to firebase
    await _firestore
        .collection(CollectionNameFirestore.getName(type: CollectionType.users))
        .doc(addUser.email)
        .set(userMap);
  }

  @override
  Future<List<userModel.User>> getUsersByName() async {
    final temp = await _firestore
        .collection(CollectionNameFirestore.getName(type: CollectionType.users))
        .get();
    return temp.docs.map((e) => userModel.User.fromJson(e.data())).toList();
  }

  @override
  Future<void> updateTokenUser({required String email}) async {
    var token = await _sessionManager.currentTokenFirebase();
    print(token);
    final result = await _firestore
        .collection(CollectionNameFirestore.getName(type: CollectionType.users))
        .doc(email)
        .update({'token': token});
    // result.
  }

  @override
  Future<void> sendNotificationMessage(
      {required Notification notification}) async {
    // await http.request('https://fcm.googleapis.com/fcm/send',
    //     options: Options(method: 'POST'),
    //     queryParameters: notification.toJson());
    var url = Uri.parse('https://fcm.googleapis.com/fcm/send');
    var headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization':
          'key=AAAAGOhsJ1E:APA91bFhu_58YHhEAkfAI8nGqZLm_uq-CqUxTxSp9GyH0Fx5vle08z2hQWIOvcKMFNhuYE_xbSyDeHhErYlxGuO5hSlfUYpsp48Hxb4xvTiicTduiFtbR_zUrAQ1hkmiWIpmhp6ipHSN',
    };
    var response = await client.post(url,
        headers: headers, body: json.encode(notification.toJson()));
    print('${response.statusCode}: ${response.body}');
  }

  @override
  Future<userModel.User> getUserByEmail({required String email}) async {
    final temp = await _firestore
        .collection(CollectionNameFirestore.getName(type: CollectionType.users))
        .doc(email)
        .get();
    if (temp.data() == null) {
      return userModel.User(email: '', name: '', token: '', userId: '');
    }
    final user = userModel.User.fromJson(temp.data()!);
    return user;
  }
}

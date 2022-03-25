import 'dart:async';

import 'package:chat_app/app/interfaces/auth_service_type.dart';
import 'package:chat_app/data/models/user.dart' as userModel;
import 'package:chat_app/tools/helper/error_handler.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService implements AuthServiceType {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Rx<bool> isVerifyEmail = false.obs;
  Timer? timer;

  userModel.User? _userFromFirebaseUser(User? user) {
    return user != null
        ? userModel.User(userId: user.uid, email: user.email!)
        : null;
  }

  @override
  Future<userModel.User> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      return _userFromFirebaseUser(user)!;
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future signInWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;

    print('Result: $result');
    return _userFromFirebaseUser(user);
  }

  @override
  Future<userModel.User> signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = result.user;

    print('Result: $result');
    return _userFromFirebaseUser(user)!;
  }

  @override
  Future resetPassword({required String email}) async {
    final result = await _auth.sendPasswordResetEmail(email: email);
    return result;
  }

  @override
  Future signOut() async {
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
    var addUser = userModel.User(email: user.email, userId: user.userId);
    Map<String, dynamic> userMap = user.toJson();

    //save user to firebase
    await _firestore.collection('users').add(userMap);
  }

  @override
  Future<List<userModel.User>> getUserByEmail({required String email}) async {
    final temp = await _firestore
        .collection('users')
        .where('email', isEqualTo: email)
        .get();
    return temp.docs.map((e) => userModel.User.fromJson(e.data())).toList();
  }
}

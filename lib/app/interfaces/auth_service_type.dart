import 'package:flutter/cupertino.dart';

import 'package:chat_app/data/models/user.dart' as userModel;

abstract class AuthServiceType {
  Future signInWithEmailAndPassword(
      {required String email, required String password});
  Future signUpWithEmailAndPassword(
      {required String email, required String password});
  Future<userModel.User> getCurrentUser();
  Future resetPassword({required String email});
  Future changePassword({required String email});
  Future signOut();
}

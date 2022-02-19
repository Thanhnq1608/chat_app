import 'package:flutter/cupertino.dart';

abstract class AuthServiceType {
  Future signInWithEmailAndPassword(
      {required String email, required String password});
  Future signUpWithEmailAndPassword(
      {required String email, required String password});
  Future resetPassword({required String email});
  Future changePassword({required String email});
  Future signOut();
}

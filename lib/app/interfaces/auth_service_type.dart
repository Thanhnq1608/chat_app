import 'package:chat_app/data/models/recent_contact.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:chat_app/data/models/notification.dart' as dataNoti;

import 'package:chat_app/data/models/user.dart' as userModel;

abstract class AuthServiceType {
  Future signInWithEmailAndPassword(
      {required String email, required String password});
  Future<userModel.User> signUpWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<userModel.User> getCurrentUser();
  Future resetPassword({required String email});
  Future changePassword({required String email});
  Future<void> createUser({required userModel.User user});
  Future<List<userModel.User>> getUsersByName();
  Future<userModel.User> getUserByEmail({required String email});
  Future<void> updateTokenUser({required String email});
  Future<void> sendNotificationMessage(
      {required dataNoti.Notification notification});
  Future signOut();
}

import 'dart:async';

import 'package:chat_app/app/components/collection_name_firestore.dart';
import 'package:chat_app/app/interfaces/message_service_type.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/data/models/user.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rx;

class MessageService extends GetxService implements MessageServiceType {
  final _firestore = FirebaseFirestore.instance;
  final _sessionManager = Get.find<SessionManager>();

  @override
  Future<void> sendMessage(
      {required Message message, required User user}) async {
    final currentUser = await _sessionManager.currentUser();
    await _firestore
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.sender))
        .doc(currentUser.email)
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.receiver))
        .doc(user.email)
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.message))
        .add(message.toJson());
  }

  @override
  Stream<List<Message>> listenMessagesFromReceiver(
      {required String currentUser, required String user}) {
    return _firestore
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.sender))
        .doc(user)
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.receiver))
        .doc(currentUser)
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.message))
        .orderBy('send_time')
        .snapshots()
        .map((snapshot) {
      List<Message> messages = [];
      messages.addAll(snapshot.docChanges
          .toList()
          .where((element) => element.doc.data() != null)
          .map((e) => Message.fromJson(e.doc.data()!))
          .toList());
      return messages;
    });
  }

  @override
  Stream<List<Message>> listenMessagesFromSender(
      {required String currentUser, required String user}) {
    return _firestore
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.sender))
        .doc(currentUser)
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.receiver))
        .doc(user)
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.message))
        .orderBy('send_time')
        .snapshots()
        .map((snapshot) {
      List<Message> messages = [];
      messages.addAll(snapshot.docChanges
          .toList()
          .where((element) => element.doc.data() != null)
          .map((e) => Message.fromJson(e.doc.data()!))
          .toList());
      return messages;
    });
  }
}

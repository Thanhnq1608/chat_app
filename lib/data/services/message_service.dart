import 'dart:async';

import 'package:chat_app/app/interfaces/message_service_type.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart' as rx;

class MessageService extends GetxService implements MessageServiceType {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<List<Message>> getListMessage() async {
    final querySnapshot = await _firestore.collection('message').get();
    return querySnapshot.docs.map((e) => Message.fromJson(e.data())).toList();
  }

  @override
  Future<void> sendMessage({required Message message}) async {
    await _firestore.collection('message').add({
      'text': message.message,
      'sender': message.sender,
      'receiver': message.receiver,
      'send_time': message.sendTime,
    });
  }

  @override
  Stream<List<Message>> listenMessagesFromReceiver(
      {required String sender, required String receiver}) {
    return _firestore
        .collection('message')
        .where('sender', isEqualTo: sender)
        .where('receiver', isEqualTo: receiver)
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
      {required String sender, required String receiver}) {
    return _firestore
        .collection('message')
        .where('sender', isEqualTo: sender)
        .where('receiver', isEqualTo: receiver)
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

import 'package:chat_app/app/interfaces/message_service_type.dart';
import 'package:chat_app/data/models/message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class MessageService extends GetxService implements MessageServiceType {
  final _firestore = FirebaseFirestore.instance;
  @override
  Future<void> sendMessage(
      {required String message, required String email}) async {
    await _firestore.collection('message').add({
      'text': message,
      'sender': email,
    });
  }

  @override
  Future<List<Message>> getListMessage() async {
    final querySnapshot = await _firestore.collection('message').get();
    return querySnapshot.docs.map((e) => Message.fromJson(e.data())).toList();
  }

  @override
  Stream<List<Message>> listenMessagesUpdate() {
    return _firestore.collection('message').snapshots().map((snapshot) {
      List<Message> messages = [];
      messages.addAll(snapshot.docChanges.reversed
          .where((element) => element.doc.data() != null)
          .map((e) => Message.fromJson(e.doc.data()!))
          .toList());
      return messages;
    });
  }
}

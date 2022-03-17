import 'package:chat_app/app/interfaces/message_service_type.dart';
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
  Future<List<Map<String, dynamic>>> getMessages() async{
    List<Map<String, dynamic>> listMessages= [];
    await for (var snapshot in _firestore.collection('message').snapshots()) {
      for (var message in snapshot.docs) {
        listMessages.add(message.data());
      }
    }
    return listMessages;
  }
}

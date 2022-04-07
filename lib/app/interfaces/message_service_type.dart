import 'package:chat_app/data/models/message.dart';
import 'package:chat_app/data/models/user.dart';

abstract class MessageServiceType {
  Future<void> sendMessage({required Message message, required User user});
  Stream<List<Message>> listenMessagesFromReceiver(
      {required String currentUser, required String user});
  Stream<List<Message>> listenMessagesFromSender(
      {required String currentUser, required String user});
}

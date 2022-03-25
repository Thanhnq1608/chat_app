import 'package:chat_app/data/models/message.dart';

abstract class MessageServiceType {
  Future<void> sendMessage({required Message message});
  Stream<List<Message>> listenMessagesFromReceiver(
      {required String sender, required String receiver});
  Stream<List<Message>> listenMessagesFromSender(
      {required String sender, required String receiver});
  Future<List<Message>> getListMessage();
}

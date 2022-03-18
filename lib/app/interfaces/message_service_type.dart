import 'package:chat_app/data/models/message.dart';

abstract class MessageServiceType {
  Future<void> sendMessage({required String message, required String email});
  Stream<List<Message>> listenMessagesUpdate();
  Future<List<Message>> getListMessage();
}

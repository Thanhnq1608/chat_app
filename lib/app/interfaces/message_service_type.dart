abstract class MessageServiceType {
  Future<void> sendMessage({required String message, required String email});
  Future<void> getMessages();
}

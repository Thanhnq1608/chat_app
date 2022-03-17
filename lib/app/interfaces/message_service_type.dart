abstract class MessageServiceType {
  Future<void> sendMessage({required String message, required String email});
  Future<List<Map<String, dynamic>>> getMessages();
}

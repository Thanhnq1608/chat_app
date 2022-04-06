import 'package:chat_app/data/models/recent_contact.dart';

abstract class RecentContactServiceType {
  Future<Stream<List<RecentContact>>> recentContact();
  Future<void> updateRecentContact(
      {required RecentContact contact, required String emailDoc});
}

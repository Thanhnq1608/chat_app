import 'package:chat_app/app/components/collection_name_firestore.dart';
import 'package:chat_app/app/interfaces/recent_contact_service_type.dart';
import 'package:chat_app/data/models/recent_contact.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class RecentContactService extends GetxService
    implements RecentContactServiceType {
  final _firestore = FirebaseFirestore.instance;
  final _sessionManager = Get.find<SessionManager>();

  @override
  Future<Stream<List<RecentContact>>> recentContact() async {
    var user = await _sessionManager.currentUser();
    return await _firestore
        .collection(CollectionNameFirestore.getName(
            type: CollectionType.recent_contact))
        .doc(user.email)
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.sub_recent))
        .orderBy('send_time')
        .snapshots()
        .map((event) {
      List<RecentContact> contacts = [];
      contacts.addAll(event.docs
          .toList()
          .map((e) => RecentContact.fromJson(e.data()))
          .toList());
      return contacts;
    });
  }

  @override
  Future<void> updateRecentContact(
      {required RecentContact contact, required String emailDoc}) async {
    final user = await _sessionManager.currentUser();
    await _firestore
        .collection(CollectionNameFirestore.getName(
            type: CollectionType.recent_contact))
        .doc(user.email)
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.sub_recent))
        .doc(emailDoc)
        .set(contact.toJson());
    RecentContact contactOfSender = RecentContact(
      isSeen: contact.isSeen,
      lastMessage: contact.lastMessage,
      sendTime: contact.sendTime,
      email: user.email,
      name: user.name,
      avatar: user.avatar,
      sender: contact.sender,
    );
    await _firestore
        .collection(CollectionNameFirestore.getName(
            type: CollectionType.recent_contact))
        .doc(emailDoc)
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.sub_recent))
        .doc(user.email)
        .set(contactOfSender.toJson());
  }

  @override
  Future<void> seenMessage({required RecentContact contact}) async {
    final user = await _sessionManager.currentUser();
    Map<String, bool> mapIsSeen = {'is_seen': true};
    await _firestore
        .collection(CollectionNameFirestore.getName(
            type: CollectionType.recent_contact))
        .doc(user.email)
        .collection(
            CollectionNameFirestore.getName(type: CollectionType.sub_recent))
        .doc(contact.email)
        .update(mapIsSeen);
  }
}

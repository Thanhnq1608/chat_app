import 'dart:ffi';

enum CollectionType {
  users,
  message,
  recent_contact,
  sub_recent,
  sender,
  receiver,
}

class CollectionNameFirestore {
  static String getName({required CollectionType type}) {
    switch (type) {
      case CollectionType.users:
        return 'users';
      case CollectionType.message:
        return 'messages';
      case CollectionType.recent_contact:
        return 'recent_contact';
      case CollectionType.sub_recent:
        return 'recent';
      case CollectionType.sender:
        return 'sender';
      case CollectionType.receiver:
        return 'receiver';
    }
  }
}

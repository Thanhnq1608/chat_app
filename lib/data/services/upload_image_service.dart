import 'dart:io';

import 'package:chat_app/app/components/collection_name_firestore.dart';
import 'package:chat_app/app/interfaces/upload_image_service_type.dart';
import 'package:chat_app/tools/session_manager/session_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as Path;

class UploadImageService extends GetxService implements UploadImageServiceType {
  final _firestore = FirebaseFirestore.instance;
  final _sessionManager = Get.find<SessionManager>();
  @override
  Future<String> uploadImageToFirebaseStorage({required File image}) async {
    var storageReference = FirebaseStorage.instance
        .ref()
        .child('profiles/${Path.basename(image.path)}}');
    var uploadTask = storageReference.putFile(image);
    await uploadTask.whenComplete(() => print('File Uploaded'));
    var imageLink = await storageReference.getDownloadURL();
    return imageLink;
  }

  @override
  Future<void> updateAvatarUser({required String avatar}) async {
    final user = await _sessionManager.currentUser();
    await _firestore
        .collection(CollectionNameFirestore.getName(type: CollectionType.users))
        .doc(user.email)
        .update({'avatar': avatar});
  }
}

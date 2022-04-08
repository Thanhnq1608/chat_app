import 'dart:io';

abstract class UploadImageServiceType {
  // https://www.c-sharpcorner.com/article/upload-image-file-to-firebase-storage-using-flutter/
  Future<String> uploadImageToFirebaseStorage({required File image});
  Future<void> updateAvatarUser({required String avatar});
}

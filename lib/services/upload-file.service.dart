import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFileToFirebaseService {
  static UploadTask? uploadFile(destination, File file, String userUID) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static void writeMedal(String userUID, String cityRef) {
    Map<String, dynamic> medal = {
      'cityRef': cityRef,
      'obtained': true,
      'obtainedDate': Timestamp.now()
    };

    FirebaseFirestore.instance.collection('players').doc(userUID).update(
      {
        'medals': FieldValue.arrayUnion([medal])
      },
    );
  }
}

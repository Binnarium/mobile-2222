import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lab_movil_2222/models/player-projects.dto.dart';

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

  static void writeMedal(String userUID, String cityRef) async {
    Map<String, dynamic> medal = {
      'cityRef': cityRef,
      'obtained': true,
      'obtainedDate': Timestamp.now()
    };

    await FirebaseFirestore.instance.collection('players').doc(userUID).update(
      {
        'projectAwards': FieldValue.arrayUnion([medal])
      },
    );
  }

  static void writePlayerProjectFile(
      String userUID, PlayerProject project) async {
    await FirebaseFirestore.instance
        .collection('players')
        .doc(userUID)
        .collection('project')
        .add(project.toMap())
        .then((value) async {
      await FirebaseFirestore.instance
          .collection('players')
          .doc(userUID)
          .collection('project')
          .doc(value.id)
          .update({'id': value.id});
    });
    print('Succesfully added project ${project.id}');
  }

  static void deletePlayerProjectFile(
      String userUID, String docID, PlayerProject project) async {
    await FirebaseStorage.instance.refFromURL(project.file.url).delete();
    print('File successfully deleted from storage');
    await FirebaseFirestore.instance
        .collection('players')
        .doc(userUID)
        .collection('project')
        .doc(docID)
        .delete();

    print('File $docID successfully deleted from firestore');
  }
}

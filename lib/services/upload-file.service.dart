import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:lab_movil_2222/models/player-projects.dto.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';

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
        'medals': FieldValue.arrayUnion([medal])
      },
    );
  }

  static void writePlayerProjectFile(
      String userUID, String cityRef, String path, String url) async {
    Map<String, dynamic> projectFile = {
      'path': path,
      'url': url,
    };
    LoadPlayerInformationService playerLoader = LoadPlayerInformationService();
    List<PlayerProject> projects = await playerLoader.loadProjects(userUID);
    bool existingProject = false;
    projects.forEach((element) {
      if (element.cityName == cityRef) {
        existingProject = true;
      }
    });
    if (existingProject) {
      await FirebaseFirestore.instance
          .collection('players')
          .doc(userUID)
          .collection('project')
          .doc(cityRef)
          .update(
        {
          'files': FieldValue.arrayUnion([projectFile])
        },
      );
    } else {
      await FirebaseFirestore.instance
          .collection('players')
          .doc(userUID)
          .collection('project')
          .doc(cityRef)
          .set({
        'completed': true,
        'files': [projectFile]
      });
    }
  }

  static void deletePlayerProjectFile(
      String userUID, String cityRef, String path, ProjectFile file) async {
    LoadPlayerInformationService playerLoader = LoadPlayerInformationService();
    List<PlayerProject> projects = await playerLoader.loadProjects(userUID);
    bool existingProject = false;
    int filesArrayLength = 0;
    Map<String, dynamic> fileMap = {
      "path": file.path,
      "url": file.url,
    };
    projects.forEach((element) {
      if (element.cityName == cityRef) {
        existingProject = true;
        element.files.forEach((element) {
          // print("PATHS: ${element.path}");
        });
        filesArrayLength = element.files.length;
        // print(filesArrayLength);
      }
    });
    if (existingProject && filesArrayLength - 1 != 0) {
      await FirebaseStorage.instance.refFromURL(file.url).delete();
      print('File successfully deleted from storage');
      await FirebaseFirestore.instance
          .collection('players')
          .doc(userUID)
          .collection('project')
          .doc(cityRef)
          .update(
        {
          'files': FieldValue.arrayRemove([fileMap])
        },
      );
      print('File reference successfully deleted from firestore');
    } else {
      await FirebaseStorage.instance.refFromURL(file.url).delete();
      print('File successfully deleted from storage');
      await FirebaseFirestore.instance
          .collection('players')
          .doc(userUID)
          .collection('project')
          .doc(cityRef)
          .delete();
      print('collection successfully deleted from players/projects');
    }
  }
}

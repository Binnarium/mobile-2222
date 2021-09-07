import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';

class LoadPlayerInformationService {
  @Deprecated('do not use this implementation')
  Future<PlayerModel> loadInformation(String userUID) async {
    final payload = await FirebaseFirestore.instance
        .collection('players')
        .doc(userUID)
        .get();

    if (!payload.exists)
      throw new ErrorDescription('Player information not found');
    return PlayerModel.fromMap(payload.data()!);
  }

  static void updateAvatar(String userUID, String filename, String path,
      String url, String oldImageURL) async {
    Map<String, dynamic> imageMap = {
      'width': 0,
      'height': 0,
      'name': filename,
      'path': path,
      'url': url,
    };
    if (oldImageURL != "") {
      try {
        await FirebaseStorage.instance.refFromURL(oldImageURL).delete();
        print('Succesfully deleted avatar from storage');
      } catch (e) {
        print('Error, no se pudo borrar desde storage (puede que no exista el'
            'archivo) $e');
      }
    }
    await FirebaseFirestore.instance.collection('players').doc(userUID).update(
      {'avatarImage': imageMap},
    );
  }
}

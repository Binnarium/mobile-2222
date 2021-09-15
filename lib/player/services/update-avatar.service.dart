import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';

class UpdateAvatarService {
  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;
  final FirebaseStorage _fStorage;

  UpdateAvatarService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance,
        _fStorage = FirebaseStorage.instance;

  Stream<bool> updateAvatar$(ImageDto avatar, String oldImageUrl) {
    return this._uploadImage(
      oldImageUrl: oldImageUrl,
      createMessageCallback: (user) => avatar,
    );
  }

  /// function that uploads a message to the specific player database reference
  Stream<bool> _uploadImage({
    required ImageDto Function(PlayerModel) createMessageCallback,
    required String oldImageUrl,
  }) {
    return this._currentPlayerService.player$.take(1).asyncMap(
      (user) async {
        if (user == null) return false;

        /// create image to upload
        ImageDto image = createMessageCallback(user);

        if (oldImageUrl != "") {
          try {
            await _fStorage.refFromURL(oldImageUrl).delete();
            print('Succesfully deleted avatar from storage');
          } catch (e) {
            print(
                'Error, no se pudo borrar desde storage (puede que no exista el'
                'archivo) $e');
          }
        }
            print('TODO: add model to update avatar');
        final DocumentReference<Map<String, dynamic>> avatarDoc =
            this._fFirestore.collection('players').doc(user.uid);
        print('USER UID: ${user.uid}');
        print('IMAGEN: ${image.url}');
        try {
          await avatarDoc.update(
            {'avatarImage': image.toMap()},
          );
          print('Image: ${image.url} satisfactorio');
          return true;
        } catch (e) {
          print('ERROR Al SUBIR IMAGEN: $e');
          return false;
        }
      },
    );
  }
}

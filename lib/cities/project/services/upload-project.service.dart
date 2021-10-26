import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/asset.dto.dart';
import 'package:lab_movil_2222/cities/project/models/player-projects.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:provider/provider.dart';

/// Class that uploads the project to the database reference
/// This class does not uploads the file, for that Implement "UploadFileService"
class UploadProjectService {
  UploadProjectService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance;

  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;

  Stream<bool> project$(CityModel city, AssetDto file) {
    return _uploadProject$(
      createMessageCallback: (user) => PlayerProject(
        cityId: city.id,
        file: file,
        kind: file.runtimeType == AudioDto ? 'PROJECT#MP3' : 'PROJECT#PDF',
        id: '',
      ),
    );
  }

  /// function that uploads a message to the specific player database reference
  Stream<bool> _uploadProject$({
    required PlayerProject Function(PlayerModel) createMessageCallback,
  }) {
    return _currentPlayerService.player$.take(1).asyncMap<bool>(
      (user) async {
        if (user == null) {
          return false;
        }

        /// create project to upload
        final PlayerProject newProject = createMessageCallback(user);
        final CollectionReference<Map<String, dynamic>> messagesDoc =
            _fFirestore
                .collection('players')
                .doc(user.uid)
                .collection('project');

        /// upload project
        try {
          await messagesDoc.add(newProject.toMap()).then(
            (value) async {
              await FirebaseFirestore.instance
                  .collection('players')
                  .doc(user.uid)
                  .collection('project')
                  .doc(value.id)
                  .update({'id': value.id});
            },
          );
          return true;
        } catch (e) {
          print(e);
          return false;
        }
      },
    );
  }

  Future<void> deletePlayerProjectFile(PlayerProject project) async {
    final PlayerModel? currentPlayer = _currentPlayerService.currentPlayer;

    /// validate player is signed in
    if (currentPlayer == null) throw Exception();

    await FirebaseStorage.instance.refFromURL(project.file.url).delete();

    await FirebaseFirestore.instance
        .collection('players')
        .doc(currentPlayer.uid)
        .collection('project')
        .doc(project.id)
        .delete();
  }
}

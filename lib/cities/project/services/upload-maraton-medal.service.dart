import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project/models/player-maraton-medal.model.dart';

import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';

class UploadMaratonMedalService {
  UploadMaratonMedalService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance;

  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;

  Stream<bool> medal$(String id) {
    return _uploadMedal(
      createMessageCallback: (user) =>
          MaratonMedalProject(isAwarded: true, playerId: id),
    );
  }

  /// function that uploads a message to the specific player database reference
  Stream<bool> _uploadMedal({
    required MaratonMedalProject Function(PlayerModel) createMessageCallback,
  }) {
    return _currentPlayerService.player$.take(1).asyncMap<bool>(
      (user) async {
        if (user == null) {
          return false;
        }

        /// create medal to upload
        ///
        bool isSend = false;
        await loadMaratonMedal(user.uid).then((value) => isSend = value);
        if (!isSend) {
          writeMedal(createMessageCallback.call(user).playerId, user.uid);
          final MaratonMedalProject newMedal = createMessageCallback(user);
          final CollectionReference<Map<String, dynamic>> messagesDoc =
              _fFirestore
                  .collection('players')
                  .doc(user.uid)
                  .collection('maraton-awards');

          /// upload medal
          try {
            await messagesDoc.add(newMedal.toMap()).then(
              (value) async {
                await FirebaseFirestore.instance
                    .collection('players')
                    .doc(user.uid)
                    .collection('maraton-awards')
                    .doc(value.id)
                    .update({'id': value.id});
              },
            );
            return true;
          } catch (e) {
            print(e);
            return false;
          }
        }
        return false;
      },
    );
  }

  static Future<bool> loadMaratonMedal(String userUID) async {
    bool isSend = false;
    await FirebaseFirestore.instance
        .collection('players')
        .doc(userUID)
        .collection('maraton-awards')
        .get()
        .then(
            (value) => value.docs.isNotEmpty ? isSend = true : isSend = false);

    return isSend;
  }

  static void writeMedal(String ownerUID, String senderUID) async {
    final Map<String, dynamic> medal = <String, dynamic>{
      'cityRef': 'Project-Award',
      'obtained': true,
      'obtainedDate': Timestamp.now(),
      'playerSender': senderUID,
    };

    await FirebaseFirestore.instance.collection('players').doc(ownerUID).update(
      {
        'maratonAwards': FieldValue.arrayUnion(<dynamic>[medal])
      },
    );
  }

  // static void deletePlayerProjectFile(
  //     String userUID, PlayerProject project) async {
  //   await FirebaseStorage.instance.refFromURL(project.file.url).delete();
  //   print('File successfully deleted from storage');
  //   await FirebaseFirestore.instance
  //       .collection('players')
  //       .doc(userUID)
  //       .collection('project')
  //       .doc(project.id)
  //       .delete();

  //   print('File ${project.id} successfully deleted from firestore');
  // }
}

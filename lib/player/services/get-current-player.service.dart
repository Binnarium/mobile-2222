import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';

class GetCurrentPlayerService {
  static Stream<PlayerModel?>? _playerStream;

  static Stream<PlayerModel?> player$() {
    if (GetCurrentPlayerService._playerStream == null) {
      /// build player stream
      final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;
      final FirebaseAuth _fAuth = FirebaseAuth.instance;

      /// TODO: make user uid is obtained from stream
      final playerRef =
          _fFirestore.collection('players').doc(_fAuth.currentUser!.uid);

      GetCurrentPlayerService._playerStream = playerRef
          .snapshots()

          /// turn snapshot into document data or null
          .map((snapshot) => snapshot.data())

          /// turn snapshot data into player object, if props found
          .map((objet) => objet == null ? null : PlayerModel.fromMap(objet));
    }

    return _playerStream!;
  }
}

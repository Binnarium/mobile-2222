import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:rxdart/rxdart.dart';

class CurrentPlayerService {
  CurrentPlayerService()
      : _firestore = FirebaseFirestore.instance,
        _auth = FirebaseAuth.instance;

  /// services
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  /// Last player status cashed value
  /// access to its value using the [CurrentPlayerService.currentPlayer]
  static PlayerModel? _player;

  /// get sync access to the current signed in player
  static PlayerModel? get currentPlayer => CurrentPlayerService._player;

  Stream<PlayerModel?> get player$ => _auth
          .userChanges()

          /// point to player document
          .map((user) => user == null
              ? null
              : _firestore.collection('players').doc(user.uid))

          /// turn document to stream of player snapshots
          .switchMap((playerDoc) =>
              playerDoc == null ? Stream.value(null) : playerDoc.snapshots())

          /// turn snapshot into document data or null
          .map((snapshot) => snapshot?.data())

          /// turn snapshot data into player object, if props found
          .map((object) {
        if (object == null) {
          CurrentPlayerService._player = null;
          return null;
        } else {
          CurrentPlayerService._player = PlayerModel.fromMap(object);
          return CurrentPlayerService._player;
        }
      }).shareReplay();
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:rxdart/rxdart.dart';

class CurrentPlayerService {
  /// singleton instance
  static CurrentPlayerService? _instance;

  /// base constructor
  CurrentPlayerService._();

  /// singleton instance constructor
  static CurrentPlayerService get instance {
    if (CurrentPlayerService._instance == null)
      CurrentPlayerService._instance = CurrentPlayerService._();
    return CurrentPlayerService._instance!;
  }

  /// services
  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Stream<PlayerModel?> get player$ => this
      ._fAuth
      .userChanges()

      /// point to player document
      .map((user) => user == null
          ? null
          : this._fFirestore.collection('players').doc(user.uid))

      /// turn document to stream of player snapshots
      .switchMap((playerDoc) =>
          playerDoc == null ? Stream.value(null) : playerDoc.snapshots())

      /// turn snapshot into document data or null
      .map((snapshot) => snapshot?.data())

      /// turn snapshot data into player object, if props found
      .map((objet) => objet == null ? null : PlayerModel.fromMap(objet))
      .shareReplay();
}

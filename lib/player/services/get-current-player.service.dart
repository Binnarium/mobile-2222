import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:rxdart/rxdart.dart';

class CurrentPlayerService {
  CurrentPlayerService(BuildContext context);

  /// services
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static PlayerModel? player;

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
          return null;
        } else {
          player = PlayerModel.fromMap(object);
          return player;
        }
      }).shareReplay();

  // void setPlayer(PlayerModel newPlayer) {
  //   player = newPlayer;
  // }
}

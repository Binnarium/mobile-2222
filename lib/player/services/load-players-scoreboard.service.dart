import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LoadPlayerScoreboardService {
  LoadPlayerScoreboardService(BuildContext context)
      : _fFirestore = FirebaseFirestore.instance,
        _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false);

  /// services
  final FirebaseFirestore _fFirestore;
  final CurrentPlayerService _currentPlayerService;

  Stream<List<PlayerModel>>? leaderBoard$;

  Stream<List<PlayerModel>> get loadScoreboard$ {
    /// get collection of users
    /// from the players collections
    /// select players with the highest level of [proactivity], and also in the same group
    /// limit select to 30 players
    leaderBoard$ ??= _currentPlayerService.player$
        .switchMap(
          (player) => _fFirestore
              .collection('players')
              .where('playerType', isEqualTo: player?.playerType)
              .orderBy('proactivity', descending: true)
              .limit(10)
              .snapshots(),
        )

        /// obtain docs of payload
        .map(
          (snap) => snap.docs.map((doc) =>
              doc.data() as Map<String, dynamic>? ?? <String, dynamic>{}),
        )

        /// map data to instances highest proactivity player
        .map(
          (docs) => docs.map((data) => PlayerModel.fromMap(data)).toList(),
        );
    return leaderBoard$!;
  }
}

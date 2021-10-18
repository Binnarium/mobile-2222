import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';

class LoadPlayerScoreboardService {
  /// services
  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  Stream<List<PlayerModel>> loadScoreboard$() {
    /// get collection of users
    /// from the players collections
    /// select players whit the highest level of [proactivity],
    /// limit select to 30 players
    final Query groupQuery =
        _fFirestore.collection('players').orderBy('proactivity', descending: true).limit(200);
    return groupQuery
        .snapshots()

        /// obtain docs of payload
        .map(
          (snap) => snap.docs.map((doc) =>
              doc.data() as Map<String, dynamic>? ?? <String, dynamic>{}),
        )

        /// map data to instances highest proactivity player
        .map(
          (docs) => docs.map((data) => PlayerModel.fromMap(data)).toList(),
        );
  } 
}

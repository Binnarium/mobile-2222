import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';

class LoadPlayerService {
  /// services
  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  Stream<PlayerModel?> load$(String userUID) {
    return this
        ._fFirestore
        .collection('players')
        .doc(userUID)
        .snapshots()

        /// turn snapshot into document data or null
        .map((snapshot) => snapshot.data())

        /// turn snapshot data into player object, if props found
        .map((objet) => objet == null ? null : PlayerModel.fromMap(objet));
  }
}

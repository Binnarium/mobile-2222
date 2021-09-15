import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:rxdart/rxdart.dart';

class ListPlayerGroupService {
  static ListPlayerGroupService? _instance;

  ListPlayerGroupService._();

  static ListPlayerGroupService get instance {
    if (ListPlayerGroupService._instance == null)
      ListPlayerGroupService._instance = ListPlayerGroupService._();
    return ListPlayerGroupService._instance!;
  }

  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  final Stream<PlayerModel?> _currentPlayer$ =
      CurrentPlayerService.instance.player$;

  Stream<List<PlayerModel>> get players$ => this._currentPlayer$.switchMap((user) {
        if (user == null) return Stream.value([]);

        /// get collection of users
        final playerCollection = this
            ._fFirestore
            .collection('players')
            .where('groupId', isEqualTo: user.groupId)
            .where('uid', isNotEqualTo: user.uid);
        return playerCollection
            .snapshots()

            /// obtain docs of payload
            .map((snapshot) => snapshot.docs.map((e) => e.data()).toList())

            /// map data to instances of grpup player
            .map(
              (docs) => docs
                  .map((data) => PlayerModel.fromMap(data))
                  .toList(),
            );
      });

}

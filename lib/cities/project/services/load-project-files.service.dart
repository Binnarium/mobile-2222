import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/project/models/player-projects.model.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:rxdart/rxdart.dart';

class LoadProjectFiles {
  final FirebaseFirestore _firestore;
  final CurrentPlayerService _currentPlayerService;

  LoadProjectFiles()
      : this._currentPlayerService = CurrentPlayerService.instance,
        this._firestore = FirebaseFirestore.instance;

  Stream<List<PlayerProject>> load$(CityDto city) {
    return this._currentPlayerService.player$.switchMap((user) {
      if (user == null) return Stream.value([]);

      final Query<Map<String, dynamic>> query = this
          ._firestore
          .collection('players')
          .doc(user.uid)
          .collection('project');

      return query
          .snapshots()
          .map(
            (payload) => payload.docs
                .map((doc) => doc.data())
                .map((data) => PlayerProject.fromMap(data))
                .toList(),
          )
          .startWith([]);
    });
  }
}

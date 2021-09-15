import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:rxdart/rxdart.dart';

Stream<List<ClubhouseModel>> LoadUserClubhouse(CityModel city) {
  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;
  final Stream<PlayerModel?> player$ = CurrentPlayerService.instance.player$;

  return player$.switchMap((user) {
    if (user == null) return Stream.value([]);

    final Query<Map<String, dynamic>> query = _fFirestore
        .collection('clubhouse')
        .where('cityId', isEqualTo: city.id)
        .where('uploaderId', isEqualTo: user.uid)
        .orderBy('date', descending: false);

    final Stream<List<ClubhouseModel>> stream = query.snapshots().map(
          (payload) => payload.docs
              .map((doc) => doc.data())
              .map((doc) => ClubhouseModel(
                    clubhouseUrl: doc['clubhouseUrl'],
                    uploaderDisplayName: doc['uploaderDisplayName'] ?? null,
                    clubhouseId: doc['clubhouseId'],
                    date: (doc['date'] as Timestamp).toDate(),
                    name: doc['name'],
                    cityId: doc['cityId'],
                    uploaderId: doc['uploaderId'],
                    scraped: (doc['scraped'] as Timestamp).toDate(),
                    id: doc['id'],
                  ))
              .toList(),
        );
    return stream;
  });
}

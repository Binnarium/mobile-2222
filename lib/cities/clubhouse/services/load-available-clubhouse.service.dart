import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

Stream<List<ClubhouseModel>> LoadAvailableClubhouseService(CityDto city) {
  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  final DateTime today = DateTime.now();
  final DateTime tomorrow = today.add(new Duration(days: 1, hours: 1));

  final Query<Map<String, dynamic>> query = _fFirestore
      .collection('clubhouse')
      .where('cityId', isEqualTo: city.id)
      .orderBy('date', descending: false)
      .where('date', isGreaterThanOrEqualTo: today)
      .where('date', isLessThanOrEqualTo: tomorrow);

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
}

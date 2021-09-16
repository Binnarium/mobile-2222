import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

Stream<List<ClubhouseModel>> LoadAvailableClubhouseService(CityModel city) {
  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  final DateTime today = DateTime.now();
  final DateTime tomorrow = today.add(Duration(days: 1, hours: 1));

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
                  clubhouseUrl: doc['clubhouseUrl'] as String,
                  uploaderDisplayName: doc['uploaderDisplayName'] as String?,
                  clubhouseId: doc['clubhouseId'] as String,
                  date: (doc['date'] as Timestamp).toDate(),
                  name: doc['name'] as String,
                  cityId: doc['cityId'] as String,
                  uploaderId: doc['uploaderId'] as String,
                  scraped: (doc['scraped'] as Timestamp).toDate(),
                  id: doc['id'] as String,
                ))
            .toList(),
      );
  return stream;
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-activity.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class LoadClubhouseService {
  LoadClubhouseService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<ClubhouseActivityModel?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('clubhouse')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map(
          (data) => data == null
              ? null
              : ClubhouseActivityModel(
                  explanation:
                      data['explanation'] as String? ?? 'Texto de ejemplo',
                  theme: data['theme'] as String? ?? 'Texto de ejemplo',
                ),
        );
  }
}

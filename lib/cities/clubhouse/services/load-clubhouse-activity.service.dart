import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-activity.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class LoadClubhouseService {
  final FirebaseFirestore _firestore;
  LoadClubhouseService() : this._firestore = FirebaseFirestore.instance;

  Stream<ClubhouseActivityModel?> load$(CityModel city) {
    return this
        ._firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('clubhouse')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? null)
        .map(
          (data) => data == null
              ? null
              : ClubhouseActivityModel(
                  explanation: data['explanation'] ?? 'Texto de ejemplo',
                  theme: data['theme'] ?? 'Texto de ejemplo',
                ),
        );
  }
}

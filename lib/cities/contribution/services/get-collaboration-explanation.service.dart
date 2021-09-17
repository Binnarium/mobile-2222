import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/contribution/models/collaborations.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class ContributionService {
  ContributionService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<CollaborationModel?> explanation$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('contribution')
        .snapshots()

        /// turn snapshot into document data or null
        .map((snapshot) => snapshot.data())

        /// turn snapshot data into explanation object, if props found
        .map(
          (data) => data == null
              ? null
              : CollaborationModel(
                  theme: data['theme'] as String? ?? 'Tema de ejemplo',
                  explanation: data['explanation'] as String? ??
                      'Explicación de ejemplo',
                  allowIdea: data['allowIdea'] == true,
                  allowLecture: data['allowLecture'] == true,
                  allowProject: data['allowProject'] == true,
                ),
        );
  }
}

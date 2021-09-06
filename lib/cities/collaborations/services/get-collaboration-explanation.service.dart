import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/collaborations/models/collaborations-activity.model.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class GetCollaborationActivityService {
  static Stream<CollaborationActivityModel?>? _collaborationExplanationStream;

  static Stream<CollaborationActivityModel?> explanation$(CityDto city) {
    if (GetCollaborationActivityService._collaborationExplanationStream ==
        null) {
      /// build player stream
      final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

      final explanationRef = _fFirestore
          .collection('cities')
          .doc(city.id)
          .collection('pages')
          .doc('contribution');

      GetCollaborationActivityService._collaborationExplanationStream =
          explanationRef
              .snapshots()

              /// turn snapshot into document data or null
              .map((snapshot) => snapshot.data())

              /// turn snapshot data into explanation object, if props found
              .map(
                (data) => data == null
                    ? null
                    : CollaborationActivityModel(
                        theme: data['theme'] ?? 'Tema de ejemplo',
                        explanation:
                            data['explanation'] ?? 'Explicación de ejemplo',
                        allowIdea: data['allowIdea'] == true,
                        allowLecture: data['allowLecture'] == true,
                        allowProject: data['allowProject'] == true,
                      ),
              );
    }

    return _collaborationExplanationStream!;
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/player/models/points-explanation.model.dart';

class GetPointsExplanationService {
  static Stream<PointsExplanationModel?>? _pointsExplanationStream;

  static Stream<PointsExplanationModel?> explanation$() {
    if (GetPointsExplanationService._pointsExplanationStream == null) {
      /// build player stream
      final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

      final explanationRef =
          _fFirestore.collection('application').doc('points-explanation');

      GetPointsExplanationService._pointsExplanationStream = explanationRef
          .snapshots()

          /// turn snapshot into document data or null
          .map((snapshot) => snapshot.data())

          /// turn snapshot data into explanation object, if props found
          .map((objet) =>
              objet == null ? null : PointsExplanationModel.fromMap(objet));
    }

    return _pointsExplanationStream!;
  }
}

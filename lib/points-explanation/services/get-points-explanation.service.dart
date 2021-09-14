import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/points-explanation/models/points-explanation.model.dart';

class GetPointsExplanationService {
  Stream<PointsExplanationModel?> explanation$() {
    /// build player stream
    final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

    final explanationRef =
        _fFirestore.collection('application').doc('points-explanation');

    return explanationRef
        .snapshots()

        /// turn snapshot into document data or null
        .map((snapshot) => snapshot.data())

        /// turn snapshot data into explanation object, if props found
        .map((objet) =>
            objet == null ? null : PointsExplanationModel.fromMap(objet));
  }
}

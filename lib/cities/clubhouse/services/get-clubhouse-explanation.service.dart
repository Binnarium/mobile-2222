import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-explanation.model.dart';

class GetClubhouseExplanationService {
  static Stream<ClubhouseExplanationModel?>? _pointsExplanationStream;

  static Stream<ClubhouseExplanationModel?> explanation$() {
    if (GetClubhouseExplanationService._pointsExplanationStream == null) {
      /// build player stream
      final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

      final explanationRef =
          _fFirestore.collection('application').doc('clubhouse-explanation');

      GetClubhouseExplanationService._pointsExplanationStream = explanationRef
          .snapshots()

          /// turn snapshot into document data or null
          .map((snapshot) => snapshot.data())

          /// turn snapshot data into explanation object, if props found
          .map((objet) =>
              objet == null ? null : ClubhouseExplanationModel.fromMap(objet));
    }

    return _pointsExplanationStream!;
  }
}

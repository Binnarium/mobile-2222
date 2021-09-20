import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-explanation.model.dart';

class GetClubhouseExplanationService {
  GetClubhouseExplanationService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<ClubhouseExplanationModel?> get explanation$ => _firestore
      .collection('application')
      .doc('clubhouse-explanation')
      .snapshots()

      /// turn snapshot into document data or null
      .map((snapshot) => snapshot.data())

      /// turn snapshot data into explanation object, if props found
      .map((objet) =>
          objet == null ? null : ClubhouseExplanationModel.fromMap(objet));
}

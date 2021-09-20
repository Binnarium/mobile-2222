import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/contribution/models/contribution-explanation.model.dart';

class GetContributionExplanationService {
  GetContributionExplanationService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<ContributionExplanationModel?> get explanation$ => _firestore
      .collection('application')
      .doc('collaboration-explanation')
      .snapshots()

      /// turn snapshot into document data or null
      .map((snapshot) => snapshot.data())

      /// turn snapshot data into explanation object, if props found
      .map((object) =>
          object == null ? null : ContributionExplanationModel.fromMap(object));
}

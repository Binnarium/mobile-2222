import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/contribution/models/contribution-explanation.model.dart';

class GetContributionExplanationService {
  final FirebaseFirestore _firestore;

  GetContributionExplanationService()
      : this._firestore = FirebaseFirestore.instance;

  Stream<ContributionExplanationModel?> get explanation$ => this
      ._firestore
      .collection('application')
      .doc('collaboration-explanation')
      .snapshots()

      /// turn snapshot into document data or null
      .map((snapshot) => snapshot.data())

      /// turn snapshot data into explanation object, if props found
      .map((objet) =>
          objet == null ? null : ContributionExplanationModel.fromMap(objet));
}

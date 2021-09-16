import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/team/models/team.model.dart';

class LoadTeamService {
  final FirebaseFirestore _firestore;
  LoadTeamService() : _firestore = FirebaseFirestore.instance;

  Stream<TeamModel?> load$() {
    return _firestore
        .collection('application')
        .doc('team')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) => data == null ? null : TeamModel.fromMap(data));
  }
}

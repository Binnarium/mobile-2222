import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';

class LoadLoginInformationService {
  final FirebaseFirestore _firestore;
  LoadLoginInformationService() : this._firestore = FirebaseFirestore.instance;

  Stream<WelcomeDto?> load$() {
    return this
        ._firestore
        .collection('cities')
        .doc('welcome')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? null)
        .map((data) => data == null ? null : WelcomeDto.fromMap(data));
  }
}

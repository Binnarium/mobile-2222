import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';

class LoadLoginInformationService {
  final FirebaseFirestore _firestore;
  LoadLoginInformationService() : _firestore = FirebaseFirestore.instance;

  Stream<WelcomeDto?> load$() {
    return _firestore
        .collection('cities')
        .doc('welcome')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) => data == null ? null : WelcomeDto.fromMap(data));
  }
}

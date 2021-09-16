import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';

class WelcomeService {
  WelcomeService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<WelcomeDto?> get load$ => _firestore
      .collection('cities')
      .doc('welcome')
      .snapshots()
      .map(
        (DocumentSnapshot<Map<String, dynamic>> snapshot) =>
            snapshot.exists ? snapshot.data() : null,
      )
      .map(
        (Map<String, dynamic>? data) =>
            data == null ? null : WelcomeDto.fromMap(data),
      );
}

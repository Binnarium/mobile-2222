import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class ArgumentIdeasService {
  ArgumentIdeasService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<List<String>> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('argument')
        .snapshots()
        .map((snapshot) => snapshot.exists ? snapshot.data() : null)
        .map((event) => event?['questions'] as List<dynamic>?)
        .map((event) => event?.map((dynamic e) => e as String).toList() ?? []);
  }
}

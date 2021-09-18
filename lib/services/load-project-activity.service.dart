import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/project-screen.model.dart';

class LoadProjectDtoService {
  final FirebaseFirestore _firestore;
  LoadProjectDtoService() : _firestore = FirebaseFirestore.instance;

  Stream<ProjectScreenModel?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('project')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) => data == null ? null : ProjectScreenModel.fromJson(data));
  }
}

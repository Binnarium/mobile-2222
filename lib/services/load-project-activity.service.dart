import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/project.model.dart';

class LoadProjectDtoService {
  final FirebaseFirestore _firestore;
  LoadProjectDtoService() : this._firestore = FirebaseFirestore.instance;

  Stream<ProjectDto?> load$(CityDto city) {
    return this
        ._firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('project')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? null)
        .map((data) => data == null ? null : ProjectDto.fromJson(data));
  }
}

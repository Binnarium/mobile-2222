import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/project/models/project-activity.model.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';

class LoadProjectDtoService {
  LoadProjectDtoService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<ProjectActivityModel?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('project')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) =>
            data == null ? null : ProjectActivityModel.fromJson(data));
  }
}

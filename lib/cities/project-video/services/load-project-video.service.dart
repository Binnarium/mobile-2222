import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/project-video/model/city-project-video.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class LoadProjectVideoService {
  final FirebaseFirestore _firestore;
  LoadProjectVideoService() : _firestore = FirebaseFirestore.instance;

  Stream<CityProjectVideoModel?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('project-video')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) =>
            data == null ? null : CityProjectVideoModel.fromMap(data));
  }
}

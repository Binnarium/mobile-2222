import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/project-video/model/city-project-video.model.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';

class LoadProjectVideoService {
  LoadProjectVideoService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

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

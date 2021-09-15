import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/final-video/model/city-final-video.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class LoadFinalVideoService {
  final FirebaseFirestore _firestore;
  LoadFinalVideoService() : _firestore = FirebaseFirestore.instance;

  Stream<CityFinalVideoModel?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('final-video')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) => data == null ? null : CityFinalVideoModel.fromMap(data));
  }
}

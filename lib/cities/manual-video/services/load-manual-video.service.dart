import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/manual-video/model/city-manual-video.model.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';

class LoadManualVideoService {
  LoadManualVideoService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<CityManualVideoModel?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('manual-video')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map(
            (data) => data == null ? null : CityManualVideoModel.fromMap(data));
  }
}

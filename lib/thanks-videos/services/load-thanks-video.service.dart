import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/thanks-videos/model/city-thanks-video.model.dart';

class LoadThanksVideoService {
  LoadThanksVideoService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<CityThanksVideoModel?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('thanks-video')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map(
            (data) => data == null ? null : CityThanksVideoModel.fromMap(data));
  }
}

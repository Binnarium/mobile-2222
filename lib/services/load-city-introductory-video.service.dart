import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/models/city-introductory-video.dto.dart';

class LoadCityIntroductoryVideoService {
  LoadCityIntroductoryVideoService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<CityIntroductoryVideoDto?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('introductory-video')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) =>
            data == null ? null : CityIntroductoryVideoDto.fromMap(data));
  }
}

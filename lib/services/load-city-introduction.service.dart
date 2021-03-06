import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/models/city-introduction.dto.dart';

class LoadCityIntroductionService {
  LoadCityIntroductionService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<CityIntroductionDto?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('introduction')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) => data == null ? null : CityIntroductionDto.fromMap(data));
  }
}

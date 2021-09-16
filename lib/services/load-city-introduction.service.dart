import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/city-introduction.dto.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class LoadCityIntroductionService {
  final FirebaseFirestore _firestore;
  LoadCityIntroductionService() : _firestore = FirebaseFirestore.instance;

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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/city-resources.dto.dart';

class LoadCityResourcesService {
  LoadCityResourcesService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<CityResourcesDto?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('resources')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) => data == null ? null : CityResourcesDto.fromMap(data));
  }
}

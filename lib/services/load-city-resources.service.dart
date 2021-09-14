import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/city-resources.dto.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class LoadCityResourcesService {
  final FirebaseFirestore _firestore;
  LoadCityResourcesService() : this._firestore = FirebaseFirestore.instance;

  Stream<CityResourcesDto?> load$(CityModel city) {
    return this
        ._firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('resources')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? null)
        .map((data) => data == null ? null : CityResourcesDto.fromMap(data));
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/city-history.dto.dart';

class LoadCityHistoryService {
  LoadCityHistoryService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<CityHistoryDto?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('history')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) => data == null ? null : CityHistoryDto.fromMap(data));
  }
}

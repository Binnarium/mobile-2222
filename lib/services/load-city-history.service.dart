import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/city-history.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadCityHistoryService {
  final FirebaseFirestore _firestore;
  LoadCityHistoryService() : this._firestore = FirebaseFirestore.instance;

  Stream<CityHistoryDto?> load$(CityDto city) {
    return this
        ._firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('history')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? null)
        .map((data) => data == null ? null : CityHistoryDto.fromMap(data));
  }
}

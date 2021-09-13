import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/city-introductory-video.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadCityIntroductoryVideoService {
  final FirebaseFirestore _firestore;
  LoadCityIntroductoryVideoService()
      : this._firestore = FirebaseFirestore.instance;

  Stream<CityIntroductoryVideoDto?> load$(CityDto city) {
    return this
        ._firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('introductory-video')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? null)
        .map((data) =>
            data == null ? null : CityIntroductoryVideoDto.fromMap(data));
  }
}

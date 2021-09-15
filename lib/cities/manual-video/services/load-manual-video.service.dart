import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/manual-video/model/city-manual-video.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class LoadManualVideoService {
  final FirebaseFirestore _firestore;
  LoadManualVideoService() : this._firestore = FirebaseFirestore.instance;

  Stream<CityManualVideoModel?> load$(CityModel city) {
    return this
        ._firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('manual-video')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? null)
        .map(
            (data) => data == null ? null : CityManualVideoModel.fromMap(data));
  }
}

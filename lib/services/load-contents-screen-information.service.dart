import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/content-dto.dto.dart';

class LoadContentsScreenInformationService {
  final FirebaseFirestore _firestore;
  LoadContentsScreenInformationService()
      : this._firestore = FirebaseFirestore.instance;

  Stream<List<ContentDto>?> load$(CityDto city) {
    return this
        ._firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('content')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? null)
        .map((event) => event?['content'] as List<dynamic>)
        .first
        .asStream()
        .map((event) => event.map((e) => ContentDto.fromJson(e)).toList());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/content-dto.dto.dart';

class LoadContentsScreenInformationService {
  LoadContentsScreenInformationService()
      : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<List<ContentDto>?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('content')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((event) => event?['content'] as List<dynamic>)
        .first
        .asStream()
        .map((event) => event
            .map((dynamic e) => ContentDto.fromJson(e as Map<String, dynamic>))
            .toList());
  }
}

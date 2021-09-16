import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/cities/micro-meso-macro/models/micro-meso-macro.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';

class LoadMicroMesoMacroService {
  final FirebaseFirestore _firestore;
  LoadMicroMesoMacroService() : _firestore = FirebaseFirestore.instance;

  Stream<MicroMesoMacroModel?> load$(CityModel city) {
    return _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('micro-meso-macro')
        .snapshots()
        .map((snapshot) => snapshot.data())
        .map((data) => data == null ? null : MicroMesoMacroModel.fromMap(data));
  }
}

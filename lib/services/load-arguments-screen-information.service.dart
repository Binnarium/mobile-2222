import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadArgumentScreenInformationService {
  final FirebaseFirestore _firestore;
  LoadArgumentScreenInformationService()
      : this._firestore = FirebaseFirestore.instance;

  Stream<List<String>?> load$(CityDto city) {
    return this
        ._firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('argument')
        .snapshots()
        .map((snapshot) => snapshot.data() ?? null)
        .map((event) => event?['questions'] as List<dynamic>)
        .first
        .asStream()
        .map((event) => event.map((e) => e.toString()).toList());
  }

  // @override
  // Future<List<String>> load() async {
  //   final data = await FirebaseFirestore.instance
  //       .collection('cities')
  //       .doc(this.options.id)
  //       .collection('pages')
  //       .doc('argument')
  //       .get();

  //   if (data.exists) {
  //     return (data.get('questions') as List<dynamic>)
  //         .map((e) => e.toString())
  //         .toList();
  //   }

  //   return [];
  // }
}

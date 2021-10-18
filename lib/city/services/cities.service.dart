import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:rxdart/rxdart.dart';

class CitiesService {
  CitiesService() : _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  Stream<List<CityModel>> get allCities$ => _firestore
          .collection('cities')
          .orderBy('stage')
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((e) => CityModel.fromMap(e.data())).toList(),
          )
          .map((cities) {
        for (int i = 0; i < cities.length - 1; i++) {
          final CityModel current = cities[i];
          final CityModel? next =
              (i + 1 == cities.length) ? null : cities[i + 1];
          if (next != null) {
            current.addNextCity(next);
          }
        }

        return cities;
      })

          ///
          .shareReplay();
}

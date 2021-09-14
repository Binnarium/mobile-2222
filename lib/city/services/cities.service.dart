import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:rxdart/rxdart.dart';

class CitiesService {
  final FirebaseFirestore _firestore;

  CitiesService() : this._firestore = FirebaseFirestore.instance;

  Stream<List<CityDto>> get allCities$ => this
          ._firestore
          .collection('cities')
          .orderBy('stage')
          .snapshots()
          .map(
            (snapshot) =>
                snapshot.docs.map((e) => CityDto.fromMap(e.data())).toList(),
          )
          .map(
        (cities) {
          for (int i = 0; i < cities.length - 1; i++) {
            CityDto current = cities[i];
            CityDto? next = (i + 1 == cities.length) ? null : cities[i + 1];
            if (next != null) current.addNextCity(next);
          }

          return cities;
        },
      ).shareReplay();
}

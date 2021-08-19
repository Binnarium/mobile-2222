import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

List<CityDto>? cities;

class LoadCitiesSettingService extends ILoadInformationService<List<CityDto>> {
  @override
  Future<List<CityDto>> load() async {
    if (cities == null) {
      final snap = await FirebaseFirestore.instance
          .collection('cities')
          .orderBy("stage")
          .get();

      List<CityDto> prevCities =
          snap.docs.map((e) => CityDto.fromMap(e.data())).toList();

      for (int i = 0; i < prevCities.length - 1; i++) {
        CityDto current = prevCities[i];
        CityDto? next = (i + 1 == prevCities.length) ? null : prevCities[i + 1];
        if (next != null) current.addNextCity(next);
      }

      cities = prevCities;
    }
    return cities!;
  }
}

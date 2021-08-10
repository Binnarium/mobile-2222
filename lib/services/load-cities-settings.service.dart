import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadCitiesSettingService extends ILoadInformationService<List<CityDto>> {
  @override
  Future<List<CityDto>> load() async {
    ///  reading chapter configurations

    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .orderBy("stage")
        .get();

    return snap.docs.map((e) => CityDto.fromMap(e.data())).toList();
  }
}

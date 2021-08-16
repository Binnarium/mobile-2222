import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city-resources.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadCityResourcesService extends ILoadOptions<CityResourcesDto, CityDto> {
  const LoadCityResourcesService({
    required final CityDto city,
  }) : super(options: city);

  @override
  Future<CityResourcesDto> load() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('resources')
        .get();

    if (!snap.exists)
      new ErrorDescription('Document resources does not exists');

    return CityResourcesDto.fromMap(snap.data()!);
  }
}

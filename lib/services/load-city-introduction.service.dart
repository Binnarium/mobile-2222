import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city-introduction.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadCityIntroductionService
    extends ILoadOptions<CityIntroductionDto, CityDto> {
  const LoadCityIntroductionService({
    required final CityDto city,
  }) : super(options: city);

  @override
  Future<CityIntroductionDto> load() async {
    final payload = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('introduction')
        .get();

    if (!payload.exists)
      throw new ErrorDescription('City introduction not found');

    return CityIntroductionDto.fromMap(payload.data()!);
  }
}

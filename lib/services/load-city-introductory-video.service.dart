import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city-introductory-video.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadCityIntroductoryVideo
    extends ILoadOptions<CityIntroductoryVideoDto, CityDto> {
  const LoadCityIntroductoryVideo({
    required final CityDto city,
  }) : super(options: city);

  @override
  Future<CityIntroductoryVideoDto> load() async {
    final payload = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('introductory-video')
        .get();

    if (!payload.exists)
      throw new ErrorDescription('City introductory video not found');

    return CityIntroductoryVideoDto.fromMap(payload.data()!);
  }
}

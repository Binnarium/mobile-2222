import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/final-video/model/city-final-video.model.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadFinalVideoService extends ILoadOptions<CityFinalVideoModel, CityDto> {
  const LoadFinalVideoService({
    required final CityDto city,
  }) : super(options: city);

  @override
  Future<CityFinalVideoModel> load() async {
    final payload = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('final-video')
        .get();

    if (!payload.exists) throw new ErrorDescription('final video not found');
    return CityFinalVideoModel.fromMap(payload.data()!);
  }
}

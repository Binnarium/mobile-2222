import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/manual-video/model/city-manual-video.model.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadManualVideoService
    extends ILoadOptions<CityManualVideoModel, CityDto> {
  const LoadManualVideoService({
    required final CityDto city,
  }) : super(options: city);

  @override
  Future<CityManualVideoModel> load() async {
    final payload = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('manual-video')
        .get();

    if (!payload.exists) throw new ErrorDescription('manual video not found');
    return CityManualVideoModel.fromMap(payload.data()!);
  }
}

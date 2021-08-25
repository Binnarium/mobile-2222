import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project-video/model/city-project-video.model.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadProjectVideoService
    extends ILoadOptions<CityProjectVideoModel, CityDto> {
  const LoadProjectVideoService({
    required final CityDto city,
  }) : super(options: city);

  @override
  Future<CityProjectVideoModel> load() async {
    final payload = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('project-video')
        .get();

    if (!payload.exists) throw new ErrorDescription('project video not found');
    return CityProjectVideoModel.fromMap(payload.data()!);
  }
}

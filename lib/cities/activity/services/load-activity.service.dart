import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/activity/model/city-activity.model.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadCityService extends ILoadOptions<CityActivityModel, CityDto> {
  const LoadCityService({
    required final CityDto city,
  }) : super(options: city);

  @override
  Future<CityActivityModel> load() async {
    final payload = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('activity')
        .get();

    if (!payload.exists) throw new ErrorDescription('activity not found');
    return CityActivityModel.fromMap(payload.data()!);
  }
}

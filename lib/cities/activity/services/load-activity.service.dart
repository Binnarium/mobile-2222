import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/activity/model/city-activity.model.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';

class LoadCityService extends ILoadInformationService<CityActivityModel> {
  @override
  Future<CityActivityModel> load() async {
    final payload = await FirebaseFirestore.instance
        .collection('application')
        .doc('activities')
        .get();

    if (!payload.exists) throw new ErrorDescription('activities not found');
    return CityActivityModel.fromMap(payload.data()!);
  }
}

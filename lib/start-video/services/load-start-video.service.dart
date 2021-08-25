import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/start-video/model/start-video.model.dart';

class LoadStartVideoService extends ILoadInformationService<StartVideoModel> {
  @override
  Future<StartVideoModel> load() async {
    final payload = await FirebaseFirestore.instance
        .collection('application')
        .doc('start-video')
        .get();

    if (!payload.exists) throw new ErrorDescription('start video not found');
    return StartVideoModel.fromMap(payload.data()!);
  }
}

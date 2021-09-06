import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/micro-meso-macro/models/micro-meso-macro.model.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';

class LoadMicroMesoMacroService
    extends ILoadOptions<MicroMesoMacroModel, CityDto> {
  const LoadMicroMesoMacroService({
    required final CityDto chapterSettings,
  }) : super(options: chapterSettings);

  @override
  Future<MicroMesoMacroModel> load() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('micro-meso-macro')
        .get();

    if (!snap.exists)
      new ErrorDescription('Document micro-meso-macro does not exists');
    final Map<String, dynamic> payload = snap.data() as Map<String, dynamic>;

    return MicroMesoMacroModel.fromMap(payload);
  }
}

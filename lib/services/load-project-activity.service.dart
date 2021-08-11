import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/project.model.dart';

class LoadProject extends ILoadInformationWithOptions<ProjectDto, CityDto> {
  const LoadProject({
    required final CityDto city,
  }) : super(options: city);

  @override
  Future<ProjectDto> load() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('project')
        .get();

    if (!snap.exists)
      throw new ErrorDescription('Document history does not exists');

    final Map<String, dynamic> payload = snap.data() as Map<String, dynamic>;
    final project = ProjectDto.fromJson(payload);
    return project;
  }
}

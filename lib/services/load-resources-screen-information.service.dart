import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/shared/models/Lecture.model.dart';
import 'package:lab_movil_2222/shared/models/OnlineResource.model.dart';
import 'package:lab_movil_2222/shared/models/city.dto.dart';

class LoadOnlineResourcesScreenInformationService
    extends ILoadInformationWithOptions<List<ResourcesDto>, CityDto> {
  const LoadOnlineResourcesScreenInformationService({
    required final CityDto chapterSettings,
  }) : super(options: chapterSettings);

  @override
  Future<List<ResourcesDto>> load() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('resources')
        .get();

    if (!snap.exists)
      new ErrorDescription('Document resources does not exists');
    final Map<String, dynamic> payload = snap.data() ?? {};
    final List<dynamic> data = payload['externalLinks'] ?? [];

    final onlineResources = data.map((e) => ResourcesDto.fromJson(e)).toList();
    return onlineResources;
  }
}

class LoadReadingsResourcesScreenInformationService
    extends ILoadInformationWithOptions<List<LecturesDto>, CityDto> {
  const LoadReadingsResourcesScreenInformationService({
    required final CityDto chapterSettings,
  }) : super(options: chapterSettings);

  @override
  Future<List<LecturesDto>> load() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('resources')
        .get();

    if (!snap.exists)
      new ErrorDescription('Document resources does not exists');
    final Map<String, dynamic> payload = snap.data() ?? {};
    final List<dynamic> data = payload['readings'] ?? [];

    final readingsResources = data.map((e) => LecturesDto.fromJson(e)).toList();

    return readingsResources;
  }
}

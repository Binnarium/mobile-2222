import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lab_movil_2222/services/i-load-content.service.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/models/VideoPodcast.model.dart';

class LoadContentsScreenInformationService
    extends ILoadContentService<List<ContentDto>> {
  @override
  Future<List<ContentDto>> loadWithSettings(
      FirebaseChapterSettings chapterSettings) async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc(chapterSettings.id)
        .collection('pages')
        .doc('content')
        .get();
    if (!snap.exists) new ErrorDescription('Document history does not exists');
    final Map<String, dynamic> payload = snap.data() as Map<String, dynamic>;
    final List<dynamic> data = payload['content'];

    // print('contents temp : $data'.toString());
    final contents = data.map((e) => ContentDto.fromJson(e)).toList();
    return contents;
  }
}

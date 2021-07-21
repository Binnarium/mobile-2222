import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/services/i-load-content.service.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';

class LoadArgumentScreenInformationService
    extends ILoadContentService<List<dynamic>> {
  @override
  Future<List> loadWithSettings(FirebaseChapterSettings chapterSettings) async {
    List<dynamic> ideasTemp = [];
    final data = await FirebaseFirestore.instance
        .collection('cities')
        .doc(chapterSettings.id)
        .collection('pages')
        .doc('argument')
        .get();

    if (data.exists) {
      ideasTemp = data.get('questions');
    }

    return ideasTemp;
  }
}

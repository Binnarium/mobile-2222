import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/services/i-load-with-options.service.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';

class LoadArgumentScreenInformationService extends ILoadInformationWithOptions<
    List<dynamic>, FirebaseChapterSettings> {
  const LoadArgumentScreenInformationService({
    required final FirebaseChapterSettings chapterSettings,
  }) : super(options: chapterSettings);

  @override
  Future<List> load() async {
    List<dynamic> ideasTemp = [];
    final data = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.options.id)
        .collection('pages')
        .doc('argument')
        .get();

    if (data.exists) {
      ideasTemp = data.get('questions');
    }

    return ideasTemp;
  }
}

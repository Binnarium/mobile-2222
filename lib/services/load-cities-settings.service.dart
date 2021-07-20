import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/services/i-load-information.service.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';

class LoadCitiesSettingService
    extends ILoadInformationService<List<FirebaseChapterSettings>> {
  @override
  Future<List<FirebaseChapterSettings>> load() async {
    ///  reading chapter configurations
    List<FirebaseChapterSettings> settingsTemp = [];

    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .orderBy("stage")
        .get();
    final settings = snap.docs
        .map((e) => FirebaseChapterSettings.fromJson(e.data()))
        .toList();
    settingsTemp = settings;
    return settingsTemp;
  }
}

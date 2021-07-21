import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';

abstract class ILoadContentService<T> {
  Future<T> loadWithSettings(FirebaseChapterSettings chapterSettings);
}

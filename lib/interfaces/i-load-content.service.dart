import 'package:lab_movil_2222/models/city.dto.dart';

@Deprecated('Use ILoadWithOptions instead')
abstract class ILoadContentService<T> {
  Future<T> loadWithSettings(CityDto chapterSettings);
}

import 'package:lab_movil_2222/shared/models/city.dto.dart';

@Deprecated('User ILoadWithOptions instead')
abstract class ILoadContentService<T> {
  Future<T> loadWithSettings(CityDto chapterSettings);
}

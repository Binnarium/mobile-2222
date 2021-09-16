import 'package:lab_movil_2222/models/asset.dto.dart';

class CityIntroductoryVideoDto {
  final VideoDto video;

  CityIntroductoryVideoDto.fromMap(Map<String, dynamic> payload)
      : video = VideoDto.fromMap(payload['video'] as Map<String, dynamic>);
}

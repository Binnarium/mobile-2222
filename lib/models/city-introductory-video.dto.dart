import 'package:lab_movil_2222/models/asset.dto.dart';

class CityIntroductoryVideoDto {
  final VideoDto video;

  CityIntroductoryVideoDto.fromMap(Map<String, dynamic> payload)
      : this.video = VideoDto.fromMap(payload['video']);
}

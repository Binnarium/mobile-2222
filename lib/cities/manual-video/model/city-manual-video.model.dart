import 'package:lab_movil_2222/models/asset.dto.dart';

class CityManualVideoModel {
  final VideoDto video;
  final String link;

  CityManualVideoModel.fromMap(Map<String, dynamic> payload)
      : this.video = VideoDto.fromMap(payload['video']),
        this.link = payload['link'] ?? 'https://google.com';
}

import 'package:lab_movil_2222/models/asset.dto.dart';

class CityManualVideoModel {
  CityManualVideoModel.fromMap(Map<String, dynamic> payload)
      : video = VideoDto.fromMap(
            payload['video'] as Map<String, dynamic>? ?? <String, dynamic>{}),
        link = payload['link'] as String? ?? 'https://google.com';

  final VideoDto video;
  final String link;
}

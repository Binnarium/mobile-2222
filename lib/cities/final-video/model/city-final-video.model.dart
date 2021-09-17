import 'package:lab_movil_2222/models/asset.dto.dart';

class CityFinalVideoModel {
  CityFinalVideoModel.fromMap(Map<String, dynamic> payload)
      : video = VideoDto.fromMap(
            payload['video'] as Map<String, dynamic>? ?? <String, dynamic>{});

  final VideoDto video;
}

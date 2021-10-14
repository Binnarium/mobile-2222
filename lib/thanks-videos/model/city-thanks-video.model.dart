import 'package:lab_movil_2222/assets/video/models/video.model.dart';

class CityThanksVideoModel {
  CityThanksVideoModel.fromMap(Map<String, dynamic> payload)
      : video = VideoModel.fromMap(
            payload['video'] as Map<String, dynamic>? ?? <String, dynamic>{});

  final VideoModel video;
}

import 'package:lab_movil_2222/assets/video/models/video.model.dart';

class CityManualVideoModel {
  CityManualVideoModel.fromMap(Map<String, dynamic> payload)
      : video = VideoModel.fromMap(
            payload['video'] as Map<String, dynamic>? ?? <String, dynamic>{}),
        link = payload['link'] as String? ?? 'https://google.com';

  final VideoModel video;
  final String link;
}

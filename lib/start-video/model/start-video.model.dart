import 'package:lab_movil_2222/assets/video/models/video.model.dart';

class StartVideoModel {
  StartVideoModel.fromMap(Map<String, dynamic> payload)
      : video = VideoModel.fromMap(payload['video'] as Map<String, dynamic>);

  final VideoModel video;
}

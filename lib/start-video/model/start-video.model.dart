import 'package:lab_movil_2222/models/asset.dto.dart';

class StartVideoModel {
  final VideoDto video;

  StartVideoModel.fromMap(Map<String, dynamic> payload)
      : this.video = VideoDto.fromMap(payload['video']);
}

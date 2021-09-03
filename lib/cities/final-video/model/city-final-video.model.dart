import 'package:lab_movil_2222/models/asset.dto.dart';

class CityFinalVideoModel {
  final VideoDto video;

  CityFinalVideoModel.fromMap(Map<String, dynamic> payload)
      : this.video = VideoDto.fromMap(payload['video']);
}

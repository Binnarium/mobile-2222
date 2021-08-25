import 'package:lab_movil_2222/models/asset.dto.dart';

class CityProjectVideoModel {
  final VideoDto video;

  CityProjectVideoModel.fromMap(Map<String, dynamic> payload)
      : this.video = VideoDto.fromMap(payload['video']);
}

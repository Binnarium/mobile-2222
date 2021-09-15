import 'package:lab_movil_2222/models/asset.dto.dart';

class ClubhouseExplanationModel {
  final String explanation;
  final String clubUrl;
  final VideoDto video;

  ClubhouseExplanationModel.fromMap(Map<String, dynamic> data)
      : explanation = data['explanation'] as String,
        clubUrl = data['clubUrl'] as String,
        video = VideoDto.fromMap(data['video'] as Map<String, dynamic>);
}

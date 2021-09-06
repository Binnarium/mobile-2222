import 'package:lab_movil_2222/models/asset.dto.dart';

class ClubhouseExplanationModel {
  final String explanation;
  final String clubUrl;
  final VideoDto video;

  ClubhouseExplanationModel.fromMap(Map<String, dynamic> data)
      : this.explanation = data['explanation'],
        this.clubUrl = data['clubUrl'],
        this.video = VideoDto.fromMap(data['video']);
}

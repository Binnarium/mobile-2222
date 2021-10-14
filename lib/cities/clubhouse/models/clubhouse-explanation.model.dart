import 'package:lab_movil_2222/assets/video/models/video.model.dart';

class ClubhouseExplanationModel {
  ClubhouseExplanationModel.fromMap(Map<String, dynamic> data)
      : explanation = data['explanation'] as String,
        clubUrl = data['clubUrl'] as String,
        video = VideoModel.fromMap(data['video'] as Map<String, dynamic>);

  final String explanation;
  final String clubUrl;
  final VideoModel video;
}

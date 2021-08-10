import 'package:lab_movil_2222/models/asset.dto.dart';

class ProjectDto {
  final String activity;
  final String explanation;
  final AudioDto audio;

  ProjectDto.fromJson(Map<String, dynamic> payload)
      : this.activity = payload['activity'] as String,
        this.explanation = payload['explanation'] as String,
        this.audio = AudioDto.fromMap(payload['audio']);
}

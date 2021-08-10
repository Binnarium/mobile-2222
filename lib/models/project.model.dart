import 'package:lab_movil_2222/models/asset.dto.dart';

class ProjectDto {
  final String activity;
  final String explanation;
  final AudioDto? audio;

  ProjectDto.fromJson(Map<String, dynamic> payload)
      : this.activity = payload['activity'] ?? 'No hay actividad definida',
        this.explanation = payload['explanation'] ??
            'No hay explicación de actividad definida',
        this.audio = payload['audio']?['url'] == null
            ? null
            : AudioDto.fromMap(payload['audio']);
}

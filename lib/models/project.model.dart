import 'package:lab_movil_2222/models/asset.dto.dart';

class ProjectDto {
  final String activity;
  final String explanation;
  final String allow;
  final AudioDto? audio;

  ProjectDto.fromJson(Map<String, dynamic> payload)
      : this.activity = payload['activity'] ?? 'No hay actividad definida',
        this.explanation = payload['explanation'] ??
            'No hay explicación de actividad definida',
        this.allow = payload['allow'] ?? 'ALLOW#NONE',
        this.audio = payload['audio']?['url'] == null
            ? null
            : AudioDto.fromMap(payload['audio']);

  bool get allowFile => this.allow == 'ALLOW#FILE';
  bool get allowAudio => this.allow == 'ALLOW#AUDIO';
  bool get allowNone => this.allow == 'ALLOW#NONE';
}

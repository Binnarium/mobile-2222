import 'package:lab_movil_2222/models/asset.dto.dart';

class ProjectDto {
  ProjectDto.fromJson(Map<String, dynamic> payload)
      : activity =
            payload['activity'] as String? ?? 'No hay actividad definida',
        explanation = payload['explanation'] as String? ??
            'No hay explicación de actividad definida',
        allow = payload['allow'] as String? ?? 'ALLOW#NONE',
        audio = payload['audio']?['url'] == null
            ? null
            : AudioDto.fromMap(payload['audio'] as Map<String, dynamic>);

  final String activity;
  final String explanation;
  final String allow;
  final AudioDto? audio;

  bool get allowFile => allow == 'ALLOW#FILE';
  bool get allowAudio => allow == 'ALLOW#AUDIO';
  bool get allowNone => allow == 'ALLOW#NONE';
}

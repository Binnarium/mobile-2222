import 'package:lab_movil_2222/assets/asset.dto.dart';

enum ProjectFileAllowed {
  PDF,
  AUDIO,
  NONE,
  NOT_IMPLEMENTED,
}

class ProjectActivityModel {
  /// constructor
  ProjectActivityModel.fromJson(Map<String, dynamic> payload)
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

  ProjectFileAllowed get allowed {
    if (allow == 'ALLOW#FILE') return ProjectFileAllowed.PDF;
    if (allow == 'ALLOW#AUDIO') return ProjectFileAllowed.AUDIO;
    if (allow == 'ALLOW#NONE') return ProjectFileAllowed.NONE;
    return ProjectFileAllowed.NOT_IMPLEMENTED;
  }
}

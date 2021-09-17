import 'package:lab_movil_2222/models/asset.dto.dart';

class WelcomeDto {
  final String pageTitle;
  final String profundityText;
  final String workloadText;
  final VideoDto welcomeVideo;

  // ignore: sort_constructors_first
  WelcomeDto.fromMap(Map<String, dynamic> payload)
      : pageTitle = payload['pageTitle'] as String? ?? 'No hay titulo definido',
        profundityText =
            payload['profundityText'] as String? ?? 'No hay texto profundidad',
        workloadText = payload['workloadText'] as String? ??
            'No hay texto de carga horaria',
        welcomeVideo =
            VideoDto.fromMap(payload['welcomeVideo'] as Map<String, dynamic>);
}

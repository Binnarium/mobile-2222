import 'package:lab_movil_2222/assets/video/models/video.model.dart';

class WelcomeDto {
  /// constructor
  WelcomeDto.fromMap(Map<String, dynamic> payload)
      : pageTitle = payload['pageTitle'] as String? ?? 'No hay titulo definido',
        profundityText =
            payload['profundityText'] as String? ?? 'No hay texto profundidad',
        workloadText = payload['workloadText'] as String? ??
            'No hay texto de carga horaria',
        welcomeVideo =
            VideoModel.fromMap(payload['welcomeVideo'] as Map<String, dynamic>);

  final String pageTitle;
  final String profundityText;
  final String workloadText;
  final VideoModel welcomeVideo;
}

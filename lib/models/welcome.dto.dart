import 'package:lab_movil_2222/models/asset.dto.dart';

class WelcomeDto {
  final String pageTitle;
  final String profundityText;
  final String workloadText;
  final VideoDto welcomeVideo;

  WelcomeDto.fromMap(Map<String, dynamic> payload)
      : this.pageTitle = payload['pageTitle'] ?? 'No hay titulo definido',
        this.profundityText =
            payload['profundityText'] ?? 'No hay texto profundidad',
        this.workloadText =
            payload['workloadText'] ?? 'No hay texto de carga horaria',
        this.welcomeVideo = VideoDto.fromMap(payload['welcomeVideo']);
}


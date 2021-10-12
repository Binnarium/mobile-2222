import 'package:lab_movil_2222/assets/models/asset.dto.dart';

class MicroMesoMacroModel {
  MicroMesoMacroModel.fromMap(final Map<String, dynamic> payload)
      : image = ImageDto.fromMap(
            payload['image'] as Map<String, dynamic>? ?? <String, dynamic>{}),
        title = payload['title'] as String? ?? '',
        subtitle = payload['subtitle'] as String? ?? '';

  final ImageDto image;
  final String title;
  final String subtitle;
}

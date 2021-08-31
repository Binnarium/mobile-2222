import 'package:lab_movil_2222/models/asset.dto.dart';

class MicroMesoMacroDto {
  final ImageDto image;
  final String title;
  final String subtitle;

  MicroMesoMacroDto.fromMap(final Map<String, dynamic> payload)
      : this.image = ImageDto.fromMap(payload['image'] ?? []),
        this.title = payload['title'] ?? "",
        this.subtitle = payload['subtitle'] ?? "";
}

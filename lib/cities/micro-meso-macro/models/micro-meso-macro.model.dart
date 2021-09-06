import 'package:lab_movil_2222/models/asset.dto.dart';

class MicroMesoMacroModel {
  final ImageDto image;
  final String title;
  final String subtitle;

  MicroMesoMacroModel.fromMap(final Map<String, dynamic> payload)
      : this.image = ImageDto.fromMap(payload['image'] ?? []),
        this.title = payload['title'] ?? "",
        this.subtitle = payload['subtitle'] ?? "";
}

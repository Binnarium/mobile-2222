import 'package:lab_movil_2222/assets/asset.dto.dart';

class PlayerProject {
  /// constructor
  PlayerProject({
    required this.cityId,
    required this.file,
    required this.kind,
    required this.id,
  });

  /// constructor
  PlayerProject.fromMap(final Map<String, dynamic> payload)
      : kind = payload['kind'] as String,
        cityId = payload['cityId'] as String,
        id = payload['id'] as String,

        /// TODO: fix this
        file = PdfDto.fromMap(
            payload['file'] as Map<String, dynamic>? ?? <String, dynamic>{});

  final String cityId;
  final AssetDto file;
  final String kind;
  final String id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': {'path': file.path, 'url': file.url},
      'id': id,
      'cityId': cityId,
      'kind': kind
    };
  }
}

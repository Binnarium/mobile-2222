import 'package:lab_movil_2222/assets/models/asset.dto.dart';

class PlayerProject {
  /// constructor
  PlayerProject({
    required this.cityID,
    required this.file,
    required this.kind,
    required this.id,
  });

  /// constructor
  PlayerProject.fromMap(final Map<String, dynamic> payload)
      : kind = payload['kind'] as String? ?? '',
        cityID = payload['cityID'] as String? ?? '',
        id = payload['id'] as String? ?? '',
        file = ProjectFileDto.fromMap(
            payload['file'] as Map<String, dynamic>? ?? <String, dynamic>{});

  final String cityID;
  final ProjectFileDto file;
  final String kind;
  final String id;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': {'path': file.path, 'url': file.url},
      'id': id,
      'cityID': cityID,
      'kind': kind
    };
  }
}

import 'package:lab_movil_2222/models/asset.dto.dart';

class PlayerProject {
  PlayerProject({
    required this.cityID,
    required this.file,
    required this.kind,
    required this.id,
  });

  final String cityID;
  final ProjectFileDto file;
  final String kind;
  final String id;

  // ignore: sort_constructors_first
  PlayerProject.fromMap(final Map<String, dynamic> payload)
      : kind = payload['kind'] as String? ?? '',
        cityID = payload['cityID'] as String? ?? '',
        id = payload['id'] as String? ?? '',
        file = ProjectFileDto.fromMap(
            payload['file'] as Map<String, dynamic>? ?? <String, dynamic>{});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'file': {'path': file.path, 'url': file.url},
      'id': id,
      'cityID': cityID,
      'kind': kind
    };
  }
}

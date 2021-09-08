import 'package:lab_movil_2222/models/asset.dto.dart';

class PlayerProject {
  final String cityID;
  final ProjectFileDto file;
  final String kind;
  final String id;

  PlayerProject({
    required this.cityID,
    required this.file,
    required this.kind,
    required this.id,
  });

  PlayerProject.fromMap(final Map<String, dynamic> payload)
      : this.kind = payload['kind'] ?? "",
        this.cityID = payload['cityID'] ?? "",
        this.id = payload['id'] ?? "",
        this.file = ProjectFileDto.fromMap(payload['file'] ?? []);

  Map<String, dynamic> toMap() {
    return {
      "file": {"path": file.path, "url": file.url},
      "id": this.id,
      "cityID": this.cityID,
      "kind": this.kind
    };
  }
}

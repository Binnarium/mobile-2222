class ProjectFile {
  final String path;
  final String url;

  ProjectFile.fromMap(final Map<String, dynamic> payload)
      : this.path = payload['path'],
        this.url = payload['url'];
}

class PlayerProject {
  final String cityID;
  final ProjectFile file;
  final String kind;
  final String id;

  PlayerProject.fromMap(final Map<String, dynamic> payload)
      : this.kind = payload['kind'] ?? "",
        this.cityID = payload['cityID'] ?? "",
        this.id = payload['id'] ?? "",
        this.file = ProjectFile.fromMap(payload['file'] ?? []);

  Map<String, dynamic> toMap() {
    return {
      "file": {"path": file.path, "url": file.url},
      "id": this.id,
      "cityID": this.cityID,
      "kind": this.kind
    };
  }
}

class ProjectFile {
  final String path;
  final String url;

  ProjectFile.fromMap(final Map<String, dynamic> payload)
      : this.path = payload['path'],
        this.url = payload['url'];
}

class PlayerProject {
  final bool completed;
  final List<ProjectFile> files;
  final String cityName;

  PlayerProject.fromMap(final Map<String, dynamic> payload, String cityName)
      : this.completed = payload['completed'],
        this.cityName = cityName,
        this.files = ((payload['files'] ?? []) as List)
            .map((e) => ProjectFile.fromMap(e))
            .toList();
}

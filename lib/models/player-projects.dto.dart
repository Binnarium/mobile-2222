class _File {
  final String path;
  final String url;

  _File.fromMap(final Map<String, dynamic> payload)
      : this.path = payload['path'],
        this.url = payload['url'];
}

class PlayerProject {
  final bool completed;
  final List<_File> files;
  final String cityName;

  PlayerProject.fromMap(final Map<String, dynamic> payload, String cityName)
      : this.completed = payload['completed'],
        this.cityName = cityName,
        this.files = ((payload['files'] ?? []) as List)
            .map((e) => _File.fromMap(e))
            .toList();
}

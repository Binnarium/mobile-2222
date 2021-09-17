class CityActivityModel {
  final String contribution;
  final String project;
  final String clubhouse;

  // ignore: sort_constructors_first
  CityActivityModel.fromMap(Map<String, dynamic> payload)
      : contribution = payload['contribution'] as String? ?? '',
        project = payload['project'] as String? ?? '',
        clubhouse = payload['clubhouse'] as String? ?? '';
}

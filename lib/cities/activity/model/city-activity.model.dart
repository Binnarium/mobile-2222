class CityActivityModel {
  /// constructor
  CityActivityModel.fromMap(Map<String, dynamic> payload)
      : contribution = payload['contribution'] as String? ?? '',
        project = payload['project'] as String? ?? '',
        clubhouse = payload['clubhouse'] as String? ?? '';

  final String contribution;
  final String project;
  final String clubhouse;
}

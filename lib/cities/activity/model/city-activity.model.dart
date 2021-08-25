class CityActivityModel {
  final String contribution;
  final String project;
  final String clubhouse;

  CityActivityModel.fromMap(Map<String, dynamic> payload)
      : this.contribution = payload['contribution'] ?? '',
        this.project = payload['project'] ?? '',
        this.clubhouse = payload['clubhouse'] ?? '';
}

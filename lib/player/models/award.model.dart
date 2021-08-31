class AwardModel {
  final String cityId;
  final bool obtained;

  AwardModel.fromMap(final Map<String, dynamic> payload)
      : this.cityId = payload['cityId'],
        this.obtained = payload['obtained'] ?? false;
}

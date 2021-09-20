class AwardModel {
  AwardModel.fromMap(final Map<String, dynamic> payload)
      : cityId = payload['cityId'] as String? ?? '',
        obtained = payload['obtained'] as bool? ?? false;

  final String cityId;
  final bool obtained;
}

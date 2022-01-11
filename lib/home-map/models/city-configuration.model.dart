class CityConfigurationModel {
  CityConfigurationModel.fromMap(final Map<String, dynamic> payload)
      : colorHex = payload['colorHex'] as int;

  final int colorHex;
}

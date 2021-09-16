class CityConfigurationModel {
  final int colorHex;

  CityConfigurationModel.fromMap(final Map<String, dynamic> payload)
      : colorHex = payload['colorHex'] as int;
}

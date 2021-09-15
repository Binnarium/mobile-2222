class CityConfigurationModel {
  final int colorHex;

  CityConfigurationModel.fromMap(final Map<String, dynamic> payload)
      : this.colorHex = payload['colorHex'];
}

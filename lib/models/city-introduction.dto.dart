class CityIntroductionDto {
  final String description;

  CityIntroductionDto.fromMap(Map<String, dynamic> payload)
      : this.description = payload['description'] ?? 'No description available';
}

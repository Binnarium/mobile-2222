class CityIntroductionDto {
  final String description;

  CityIntroductionDto.fromMap(Map<String, dynamic> payload)
      : description =
            payload['description'] as String? ?? 'No description available';
}

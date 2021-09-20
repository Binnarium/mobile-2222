class CityIntroductionDto {
  CityIntroductionDto.fromMap(Map<String, dynamic> payload)
      : description =
            payload['description'] as String? ?? 'No description available';

  final String description;
}

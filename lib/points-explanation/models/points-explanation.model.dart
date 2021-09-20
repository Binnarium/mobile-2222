class PointsExplanationModel {
  PointsExplanationModel.fromMap(Map<String, dynamic> data)
      : explanation = data['explanation'] as String? ?? '';

  final String explanation;
}

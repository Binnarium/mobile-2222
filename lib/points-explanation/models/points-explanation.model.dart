class PointsExplanationModel {
  final String explanation;

  PointsExplanationModel.fromMap(Map<String, dynamic> data)
      : explanation = data['explanation'] as String? ?? '';
}

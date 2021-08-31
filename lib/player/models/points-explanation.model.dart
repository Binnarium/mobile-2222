class PointsExplanationModel {
  final String explanation;

  PointsExplanationModel.fromMap(Map<String, dynamic> data)
      : this.explanation = data['explanation'];
}

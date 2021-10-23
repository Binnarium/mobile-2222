class CompetenceModel {
  /// constructor
  CompetenceModel({
    required this.name,
    this.kind,
    required this.image,
    this.id,
  });

  final String name;
  final String? kind;
  final Map<String, dynamic> image;
  final String? id;

  static CompetenceModel fromJson(Map<String, dynamic> payload) {
    return CompetenceModel(
      name: payload['name'] as String,
      image: payload['image'] as Map<String, dynamic>,
      id: payload['id'] as String? ?? '',
      kind: payload['kind'] as String? ?? '',
    );
  }
}

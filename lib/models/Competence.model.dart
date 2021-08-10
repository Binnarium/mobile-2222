class CompetenceModel {
  final String name;
  final String? kind;
  final Map<String, dynamic> image;
  final String? id;

  CompetenceModel({
    required this.name,
    this.kind,
    required this.image,
    this.id,
  });

  static CompetenceModel fromJson(Map<String, dynamic> payload) {
    return CompetenceModel(
      name: payload["name"],
      image: payload["image"],
      id: payload["id"],
      kind : payload["kind"],
    );
  }
}

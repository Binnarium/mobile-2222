class CollaborationModel {
  CollaborationModel({
    required this.pubUrl,
    required this.explanation,
    required this.thematic,
  });

  CollaborationModel.fromMap(
    Map<String, dynamic> data, {
    required this.thematic,
  })  : pubUrl = data['pubUrl'] as String? ?? 'Tema de ejemplo',
        explanation =
            data['explanation'] as String? ?? 'Explicación de ejemplo';

  final String explanation;
  final String thematic;
  final String pubUrl;
}

class CollaborationModel {
  final String explanation;
  final String theme;
  final bool allowIdea;
  final bool allowLecture;
  final bool allowProject;

  CollaborationModel({
    required this.theme,
    required this.explanation,
    required this.allowIdea,
    required this.allowLecture,
    required this.allowProject,
  });
}

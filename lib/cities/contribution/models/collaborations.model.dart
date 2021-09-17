class CollaborationModel {
  CollaborationModel({
    required this.theme,
    required this.explanation,
    required this.allowIdea,
    required this.allowLecture,
    required this.allowProject,
  });

  final String explanation;
  final String theme;
  final bool allowIdea;
  final bool allowLecture;
  final bool allowProject;
}

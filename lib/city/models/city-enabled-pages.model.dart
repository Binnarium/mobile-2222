class CityEnabledPagesModel {
  final bool resources;
  final bool introductoryVideo;
  final bool argumentation;
  final bool manualVideo;
  final bool projectVideo;
  final bool microMesoMacro;
  final bool finalVideo;
  final bool content;

  /// activities
  final bool activities;
  final bool contribution;
  final bool contributionExplanation;
  final bool clubhouse;
  final bool clubhouseExplanation;
  final bool project;
  final bool hackatonMedals;

  // ignore: sort_constructors_first
  CityEnabledPagesModel.fromMap(final Map<String, dynamic> payload)
      : activities = payload['activities'] == true,
        contribution = payload['contribution'] == true,
        contributionExplanation = payload['contributionExplanation'] == true,
        clubhouseExplanation = payload['clubhouseExplanation'] == true,
        clubhouse = payload['clubhouse'] == true,
        resources = payload['resources'] == true,
        introductoryVideo = payload['introductoryVideo'] == true,
        argumentation = payload['argumentation'] == true,
        manualVideo = payload['manualVideo'] == true,
        projectVideo = payload['projectVideo'] == true,
        content = payload['content'] == true,
        microMesoMacro = payload['microMesoMacro'] == true,
        finalVideo = payload['finalVideo'] == true,
        project = payload['project'] == true,
        hackatonMedals = payload['hackatonMedals'] == true;

  bool get enableClubhouse => clubhouse || clubhouseExplanation;
  bool get enableContribution => contribution || contributionExplanation;
  bool get enableProject => project || projectVideo;
}

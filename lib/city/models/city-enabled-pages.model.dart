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

  CityEnabledPagesModel.fromMap(final Map<String, dynamic> payload)
      : this.activities = payload['activities'] == true,
        this.contribution = payload['contribution'] == true,
        this.contributionExplanation =
            payload['contributionExplanation'] == true,
        this.clubhouseExplanation = payload['clubhouseExplanation'] == true,
        this.clubhouse = payload['clubhouse'] == true,
        this.resources = payload['resources'] == true,
        this.introductoryVideo = payload['introductoryVideo'] == true,
        this.argumentation = payload['argumentation'] == true,
        this.manualVideo = payload['manualVideo'] == true,
        this.projectVideo = payload['projectVideo'] == true,
        this.content = payload['content'] == true,
        this.microMesoMacro = payload['microMesoMacro'] == true,
        this.finalVideo = payload['finalVideo'] == true,
        this.project = payload['project'] == true,
        this.hackatonMedals = payload['hackatonMedals'] == true;

  bool get enableClubhouse => this.clubhouse || this.clubhouseExplanation;
  bool get enableContribution =>
      this.contribution || this.contributionExplanation;
  bool get enableProject => this.project || this.projectVideo;
}

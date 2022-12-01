class WorkshopMedalModel {
  WorkshopMedalModel({
    required this.awardedToUid,
  });

  WorkshopMedalModel.fromMap(final Map<String, dynamic> payload)
      : awardedToUid = payload['awardedToUid'] as String? ?? '';

  final String awardedToUid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'awardedToUid': awardedToUid,
    };
  }
}

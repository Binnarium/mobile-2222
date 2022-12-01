class MarathonMedalModel {
  MarathonMedalModel({
    required this.awardedToUid,
  });

  MarathonMedalModel.fromMap(final Map<String, dynamic> payload)
      : awardedToUid = payload['awardedToUid'] as String? ?? '';

  final String awardedToUid;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'awardedToUid': awardedToUid,
    };
  }
}

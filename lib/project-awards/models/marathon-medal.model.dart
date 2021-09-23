class MarathonMedalModel {
  MarathonMedalModel({
    required this.playerUid,
    required this.isAwarded,
  });

  MarathonMedalModel.fromMap(final Map<String, dynamic> payload)
      : playerUid = payload['playerUid'] as String? ?? '',
        isAwarded = payload['isAwarded'] as bool? ?? false;

  final String playerUid;
  final bool isAwarded;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'playerUid': playerUid,
      'isAwarded': isAwarded,
    };
  }
}

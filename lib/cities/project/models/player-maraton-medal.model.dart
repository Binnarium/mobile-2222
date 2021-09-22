class MaratonMedalProject {
  MaratonMedalProject({
    required this.playerId,
    required this.isAwarded,
  });

  MaratonMedalProject.fromMap(final Map<String, dynamic> payload)
      : playerId = payload['playerId'] as String? ?? '',
        isAwarded = payload['isAwarded'] as bool? ?? false;

  final String playerId;
  final bool isAwarded;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'playerId': playerId,
      'isAwarded': isAwarded,
    };
  }
}

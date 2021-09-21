class MaratonMedalProject {
  final String playerId;
  final bool isAwarded;

  MaratonMedalProject({
    required this.playerId,
    required this.isAwarded,
  });

  MaratonMedalProject.fromMap(final Map<String, dynamic> payload)
      : this.playerId = payload['playerId'] ?? "",
        this.isAwarded = payload['isAwarded']?? false ;

  Map<String, dynamic> toMap() {
    return {
      "playerId": this.playerId,
      "isAwarded": this.isAwarded,
    };
  }
}

class SearchChatQueryModel {
  final String playerId;
  final String query;

  SearchChatQueryModel({
    required this.playerId,
    required this.query,
  });

  Map<String, dynamic> toMap() {
    return {
      'query': this.query,
      'playerId': this.playerId,
    };
  }
}

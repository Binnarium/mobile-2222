class SearchChatQueryModel {
  /// constructor
  SearchChatQueryModel({
    required this.playerId,
    required this.query,
  });

  /// params
  final String playerId;
  final String query;

  Map<String, dynamic> toMap() {
    return <String, String>{
      'query': query,
      'playerId': playerId,
    };
  }
}

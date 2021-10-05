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

class SearchChatResponseModel {
  /// constructor
  SearchChatResponseModel.fromMap(Map<String, dynamic> map)
      : id = map['id'] as String,
        name = map['name'] as String?,
        participantsNames = (map['participantsNames'] as List)
            .map((dynamic e) => e as String)
            .toList(),
        participantsUids = (map['participantsUids'] as List)
            .map((dynamic e) => e as String)
            .toList();

  /// params
  final String id;
  final String? name;
  final List<String> participantsUids;
  final List<String> participantsNames;
}

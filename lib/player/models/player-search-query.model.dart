class PlayerSearchQueryModel {
  final String query;
  final String? groupId;

  PlayerSearchQueryModel({
    required this.query,
    this.groupId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'query': query,
      if (groupId != null) 'groupId': groupId,
    };
  }
}

class PlayerSearchQueryModel {
  PlayerSearchQueryModel({
    required this.query,
    this.groupId,
  });

  final String query;
  final String? groupId;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'query': query,
      if (groupId != null) 'groupId': groupId,
    };
  }
}

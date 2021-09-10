class PlayerSearchQueryModel {
  final String query;
  final String? groupId;

  PlayerSearchQueryModel({
    required this.query,
    this.groupId,
  });

  Map<String, dynamic> toMap() {
    return {
      'query': this.query,
      if (this.groupId != null) 'groupId': this.groupId,
    };
  }
}

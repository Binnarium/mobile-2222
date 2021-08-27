class PlayerSearchResultModel {
  final String uid;
  final String displayName;
  final String email;

  PlayerSearchResultModel.fromMap(Map<String, dynamic> map)
      : this.uid = map['uid'],
        this.displayName = map['displayName'],
        this.email = map['email'];
}

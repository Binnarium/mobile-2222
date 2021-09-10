class SearchPlayerResultModel {
  final String uid;
  final String displayName;
  final String email;

  SearchPlayerResultModel.fromMap(Map<String, dynamic> map)
      : this.uid = map['uid'],
        this.displayName = map['displayName'],
        this.email = map['email'];
}

class SearchPlayerResultModel {
  final String uid;
  final String displayName;
  final String email;

  SearchPlayerResultModel.fromMap(Map<String, dynamic> map)
      : uid = map['uid'] as String,
        displayName = map['displayName'] as String,
        email = map['email'] as String;
}

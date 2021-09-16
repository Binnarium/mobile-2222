class ChatParticipantModel {
  final String uid;
  final String displayName;

  ChatParticipantModel({
    required this.uid,
    required this.displayName,
  });

  ChatParticipantModel.fromMap(Map<String, dynamic> map)
      : uid = map['uid'] as String,
        displayName = map['displayName'] as String;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
    };
  }
}

class ChatParticipantModel {
  final String uid;
  final String displayName;

  ChatParticipantModel({
    required this.uid,
    required this.displayName,
  });

  ChatParticipantModel.fromMap(Map<String, dynamic> map)
      : this.uid = map['uid'],
        this.displayName = map['displayName'];

  Map<String, dynamic> toMap() {
    return {
      "uid": this.uid,
      "displayName": this.displayName,
    };
  }
}

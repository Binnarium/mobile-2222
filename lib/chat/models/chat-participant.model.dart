class ChatParticipantModel {
  final String uid;
  final String displayName;

  ChatParticipantModel.fromMap(Map<String, dynamic> map)
      : this.uid = map['uid'],
        this.displayName = map['displayName'];
}

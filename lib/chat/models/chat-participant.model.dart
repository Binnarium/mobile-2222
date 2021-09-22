class ChatParticipantModel {
  ChatParticipantModel({
    required this.uid,
    required this.displayName,
    this.canSendMessage,
  });

  ChatParticipantModel.fromMap(Map<String, dynamic> map)
      : uid = map['uid'] as String,
        displayName = map['displayName'] as String,
        canSendMessage = map['canSendMessage'] == true;

  final String uid;
  final bool? canSendMessage;
  final String displayName;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'displayName': displayName,
      if (canSendMessage != null) 'canSendMessage': canSendMessage,
    };
  }
}

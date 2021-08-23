import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';

import 'chat-participant.model.dart';

class ChatModel {
  /// unique identifier of the chat
  final String id;

  /// status of the chat, in case it has been disabled
  final bool disabled;

  /// date of last activity
  final DateTime lastActivity;

  /// last message sended
  final MessageModel? lastMessage;

  /// list of participants
  final List<ChatParticipantModel> participants;

  /// list of user identifiers of the participants in the chat
  final List<String> participantsUids;

  ChatModel.fromMap(Map<String, dynamic> map)
      : this.id = map['id'],
        this.disabled = map['disabled'],
        this.lastActivity = (map['lastActivity'] as Timestamp).toDate(),
        this.participants = ((map['participants'] ?? []) as List<dynamic>)
            .map((e) => ChatParticipantModel.fromMap(e))
            .toList(),
        this.participantsUids = (map['participantsUids'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        this.lastMessage = map['lastMessage'] == null
            ? null
            : MessageModel.fromMap(map['lastMessage']);

  String get participantsNames =>
      this.participants.map((e) => e.displayName).join(', ');
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';

import 'chat-participant.model.dart';

class ChatModel {
  /// unique identifier of the chat
  final String id;

  /// unique identifier of the chat
  final String? name;

  /// status of the chat, in case it has been disabled
  final bool disabled;

  /// when ever all participants were assigned to the chat
  final bool participantsCompleted;

  /// date of last activity
  final DateTime lastActivity;

  /// date when indexed to search index
  final DateTime? indexedDate;

  /// last message sended
  final MessageModel? lastMessage;

  /// list of participants
  final List<ChatParticipantModel> participants;

  /// list of user identifiers of the participants in the chat
  final List<String> participantsUids;

  ChatModel.fromMap(Map<String, dynamic> map)
      : this.id = map['id'],
        this.disabled = map['disabled'],
        this.participantsCompleted = map['participantsCompleted'] == true,
        this.name = map['name'] ?? null,
        this.lastActivity = (map['lastActivity'] as Timestamp).toDate(),
        this.indexedDate = (map['indexedDate'] as Timestamp?)?.toDate(),
        this.participants = ((map['participants'] ?? []) as List<dynamic>)
            .map((e) => ChatParticipantModel.fromMap(e))
            .toList(),
        this.participantsUids = (map['participantsUids'] as List<dynamic>)
            .map((e) => e.toString())
            .toList(),
        this.lastMessage = map['lastMessage'] == null
            ? null
            : MessageModel.fromMap(map['lastMessage']);


  String get chatName => this.name != null
      ? this.name!
      : this
          .participants
          .map((e) => e.displayName)
          .map((name) => name.split(' ').sublist(0, 2).join(' '))
          .join(', ');
}

import 'package:lab_movil_2222/chat/models/message.model.dart';

import 'chat-participant.model.dart';

class ChatModel {
  /// unique identifier of the chat
  final String id;

  /// type of chat
  final String kind;

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

  ChatModel({
    required this.id,
    required this.name,
    required this.disabled,
    required this.participantsCompleted,
    required this.lastActivity,
    required this.indexedDate,
    required this.lastMessage,
    required this.participants,
    required this.participantsUids,
    required this.kind,
  });

  String get chatName => this.name != null
      ? this.name!
      : this
          .participants
          .map((e) => e.displayName)
          .map((name) => name.split(' ').sublist(0, 2).join(' '))
          .join(', ');

  bool get isGeneralChat => this.kind == 'CHAT#GENERAL';
  bool get isGroupChat => this.kind == 'CHAT#GROUP';
  bool get isPersonalChat => this.kind == 'CHAT#PERSONAL';
}

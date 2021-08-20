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

  /// list of names of the participants in the chat
  final List<String> participantsNames;

  /// list of user identifiers of the participants in the chat
  final List<String> participantsUid;

  const ChatModel({
    required this.id,
    required this.participants,
    required this.lastActivity,
    required this.disabled,
    required this.participantsNames,
    required this.participantsUid,
    this.lastMessage,
  });
}

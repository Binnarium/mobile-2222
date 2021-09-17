import 'package:cloud_firestore/cloud_firestore.dart';
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

  // ignore: sort_constructors_first
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

  // ignore: sort_constructors_first
  ChatModel.fromMap(
    Map<String, dynamic> data, {
    required String currentUserId,
  })  : id = data['id'] as String,
        kind = data['kind'] as String,
        disabled = data['disabled'] as bool,
        participantsCompleted = data['participantsCompleted'] == true,
        name = data['name'] as String?,
        lastActivity = (data['lastActivity'] as Timestamp).toDate(),
        indexedDate = (data['indexedDate'] as Timestamp?)?.toDate(),
        participants = (data['participants'] as List<dynamic>?)
                ?.map((dynamic e) =>
                    ChatParticipantModel.fromMap(e as Map<String, dynamic>))
                .toList() ??
            [],
        participantsUids = (data['participantsUids'] as List<dynamic>)
            .map((dynamic e) => e.toString())
            .toList(),
        lastMessage = data['lastMessage'] == null
            ? null
            : MessageModel.fromMap(
                data['lastMessage'] as Map<String, dynamic>,
                currentUid: currentUserId,
              );

  String get chatName => name != null
      ? name!
      : isGroupChat
          ? 'Grupo de 10'
          : participants
              .map((e) => e.displayName)
              .map((name) => name.split(' ').sublist(0, 1).join(' '))
              .join(', ');

  bool get isGeneralChat => kind == 'CHAT#GENERAL';
  bool get isGroupChat => kind == 'CHAT#GROUP';
  bool get isPersonalChat => kind == 'CHAT#PERSONAL';
}

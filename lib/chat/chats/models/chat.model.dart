import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/chat/chats/models/chat-kind.enum.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';

import '../../models/chat-participant.model.dart';

class ChatModel {
  ChatModel({
    required this.id,
    required this.disabled,
    required this.participantsCompleted,
    required this.lastActivity,
    required this.indexedDate,
    required this.lastMessage,
    required this.participants,
    required this.participantsUids,
    required this.kind,
    required this.currentUserId,
  });

  ChatModel.fromMap(
    Map<String, dynamic> data, {
    required this.currentUserId,
  })  : id = data['id'] as String,
        kind = _getKindFromString(data['kind'] as String),
        disabled = data['disabled'] as bool,
        participantsCompleted = data['participantsCompleted'] == true,
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

  /// unique identifier of the chat
  final String id;

  final String currentUserId;

  /// type of chat
  final ChatKind kind;

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

  String get chatName => kind == ChatKind.general

      ///  general
      ? 'General'
      : kind == ChatKind.group

          ///  group
          ? 'Grupo de 10'

          ///  personal
          : participants
              .where((e) => e.uid != currentUserId)
              .map((e) => e.displayName)
              .map((name) => name.split(' ').sublist(0, 1).join(' '))
              .join(', ');

  /// TODO: remove this from chat since chat has a responsabilitiy not necessary
  String get chatContent {
    if (lastMessage == null) {
      return 'No hay mensajes';
    }
    final String prefix =
        '${lastMessage!.sender.displayName.split(' ').first}: ';

    final String suffix = lastMessage!.minifiedMessageContent;

    return '$prefix$suffix';
  }
}

ChatKind _getKindFromString(String kind) {
  if (kind == 'CHAT#GENERAL') return ChatKind.general;
  if (kind == 'CHAT#GROUP') return ChatKind.group;
  if (kind == 'CHAT#PERSONAL') return ChatKind.personal;
  throw Error();
}

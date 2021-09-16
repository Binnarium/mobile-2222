import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class GetChatService {
  final FirebaseFirestore _firestore;
  final CurrentPlayerService _currentPlayerService;

  GetChatService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _firestore = FirebaseFirestore.instance;

  Future<ChatModel?> getChatWithId(String chatId) {
    return _currentPlayerService.player$.take(1).switchMap(
      (currentPlayer) {
        if (currentPlayer == null) return Stream.value(null);

        /// get collection of users
        final chatsDoc = _firestore.collection('chats').doc(chatId);
        return chatsDoc
            .snapshots()

            /// obtain docs of payload
            .map((snapshot) => snapshot.exists ? snapshot.data() : null)

            /// map data to instances of chat
            .map(
              (data) => data == null
                  ? null
                  : ChatModel(
                      id: data['id'] as String,
                      kind: data['kind'] as String,
                      disabled: data['disabled'] as bool,
                      participantsCompleted:
                          data['participantsCompleted'] == true,
                      name: data['name'] as String?,
                      lastActivity:
                          (data['lastActivity'] as Timestamp).toDate(),
                      indexedDate:
                          (data['indexedDate'] as Timestamp?)?.toDate(),
                      participants:
                          (data['participants'] as List<Map<String, dynamic>>?)
                                  ?.map((e) => ChatParticipantModel.fromMap(e))
                                  .toList() ??
                              [],
                      participantsUids: (data['participantsUids']
                              as List<Map<String, dynamic>>)
                          .map((e) => e.toString())
                          .toList(),
                      lastMessage:
                          (data['lastMessage'] as Map<String, dynamic>?) == null
                              ? null
                              : MessageModel.fromMap(
                                  data['lastMessage'] as Map<String, dynamic>,
                                  currentUid: currentPlayer.uid,
                                ),
                    ),
            );
      },
    ).first;
  }
}

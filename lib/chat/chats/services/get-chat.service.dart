import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/chats/models/chat.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class GetChatService {
  GetChatService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  final CurrentPlayerService _currentPlayerService;

  Future<ChatModel?> getChatWithId(String chatId) {
    return _currentPlayerService.player$.take(1).switchMap(
      (currentPlayer) {
        if (currentPlayer == null) {
          return Stream.value(null);
        }

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
                  : ChatModel.fromMap(data, currentUserId: currentPlayer.uid),
            );
      },
    ).first;
  }
}

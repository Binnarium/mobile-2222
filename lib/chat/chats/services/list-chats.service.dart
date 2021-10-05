import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/chats/models/chat-kind.enum.dart';
import 'package:lab_movil_2222/chat/chats/models/chat.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

/// list the chats available for a player
class ListChatsService {
  ListChatsService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false);

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CurrentPlayerService _currentPlayerService;

  Stream<List<ChatModel>> get chats$ => _currentPlayerService.player$.switchMap(
        (currentUser) {
          if (currentUser == null) {
            return Stream.value(<ChatModel>[]);
          }

          /// get collection of chats
          final Query query = _firestore
              .collection('chats')
              .where('participantsUids', arrayContains: currentUser.uid)
              .orderBy('lastActivity', descending: true);

          return query
              .snapshots()

              /// obtain docs of payload
              .map(
                (snap) => snap.docs.map((s) =>
                    s.data() as Map<String, dynamic>? ?? <String, dynamic>{}),
              )

              /// map data to instances of chat
              .map(
                (docs) => docs
                    .map((data) =>
                        ChatModel.fromMap(data, currentUserId: currentUser.uid))
                    .toList(),
              );
        },
      ).shareReplay();

  Stream<List<ChatModel>> get personalChats$ => chats$.map(
        (chats) =>
            chats.where((chat) => chat.kind == ChatKind.personal).toList(),
      );
}

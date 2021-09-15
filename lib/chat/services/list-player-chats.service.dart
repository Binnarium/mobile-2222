import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ListPlayerChatsService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final CurrentPlayerService _currentPlayerService;

  ListPlayerChatsService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false);

  Stream<List<ChatModel>> get chats$ =>
      _currentPlayerService.player$.switchMap((currentUser) {
        if (currentUser == null) return Stream.value([]);

        /// get collection of users
        final Query chatsCollection = _firestore
            .collection('chats')
            .where('participantsUids', arrayContains: currentUser.uid)
            .orderBy('lastActivity', descending: true);

        return chatsCollection
            .snapshots()

            /// obtain docs of payload
            .map(
              (snap) => snap.docs.map((s) => s.data() as Map<String, dynamic>),
            )

            /// map data to instances of chat
            .map(
              (docs) => docs
                  .map((data) =>
                      ChatModel.fromMap(data, currentUserId: currentUser.uid))
                  .toList(),
            );
      });
}

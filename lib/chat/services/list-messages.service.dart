import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message-with-snapshot.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ListMessagesService {
  ListMessagesService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance;

  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;

  Future<List<MessageWithSnapshotModel>> list$(
    ChatModel chat, {
    DocumentSnapshot? lastLoadedMessageSnapshot,
  }) {
    Query<Map<String, dynamic>> query = _fFirestore
        .collection('chats')
        .doc(chat.id)
        .collection('messages')
        .orderBy('sendedDate')
        .limitToLast(15);

    if (lastLoadedMessageSnapshot != null)
      query = query.endBeforeDocument(lastLoadedMessageSnapshot);

    final Stream<QuerySnapshot<Map<String, dynamic>>> snapshots$ =
        query.snapshots().take(1);

    final Stream<List<MessageWithSnapshotModel>> messages$ = Rx.combineLatest2(
      _currentPlayerService.player$.take(1),
      snapshots$,
      (PlayerModel? player, QuerySnapshot<Map<String, dynamic>> snapshot) =>
          snapshot.docs
              .map(
                (docSnap) => MessageWithSnapshotModel(
                  message: MessageModel.fromMap(
                    docSnap.data(),
                    currentUid: player?.uid ?? '',
                  ),
                  snapshot: docSnap,
                ),
              )
              .toList(),
    );

    return messages$.single;
  }
}

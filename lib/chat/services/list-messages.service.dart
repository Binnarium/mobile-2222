import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ListMessagesService {
  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;

  ListMessagesService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance;

  Stream<List<MessageModel>> list$(ChatModel chat) {
    final Stream<List<Map<String, dynamic>>> snapshots$ = _fFirestore
        .collection('chats')
        .doc(chat.id)
        .collection('messages')
        .orderBy('sendedDate')
        .snapshots()
        .map((snaps) => snaps.docs.map((e) => e.data()).toList());

    final Stream<List<MessageModel>> messages$ = Rx.combineLatest2(
      _currentPlayerService.player$.take(1),
      snapshots$,
      (PlayerModel? player, List<Map<String, dynamic>> data) => data
          .map(
            (e) => MessageModel.fromMap(e, currentUid: player?.uid ?? ''),
          )
          .toList(),
    );

    return messages$;
  }
}

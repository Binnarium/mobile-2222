import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:rxdart/rxdart.dart';

class ListMessagesService {
  FirebaseFirestore _fFirestore = FirebaseFirestore.instance;
  Stream<PlayerModel?> _player$ = CurrentPlayerService.instance.player$;

  Stream<List<MessageModel>> list$(ChatModel chat) {
    final Stream<List<Map<String, dynamic>>> snapshots$ = this
        ._fFirestore
        .collection('chats')
        .doc(chat.id)
        .collection('messages')
        .orderBy('sendedDate')
        .snapshots()
        .map((snaps) => snaps.docs.map((e) => e.data()).toList());

    final Stream<List<MessageModel>> messages$ = Rx.combineLatest2(
      this._player$,
      snapshots$,
      (PlayerModel? player, List<Map<String, dynamic>> data) => data
          .map(
            (e) => MessageModel.fromMap(e, currentUid: player?.uid ?? ''),
          )
          .toList(),
    );

    return messages$;
  }

  /// singleton
  static ListMessagesService? _instance;

  static ListMessagesService get instance {
    if (ListMessagesService._instance == null)
      ListMessagesService._instance = ListMessagesService();
    return ListMessagesService._instance!;
  }
}

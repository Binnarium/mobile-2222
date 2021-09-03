import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';

class SendMessagesService {
  /// singleton
  static SendMessagesService? _instance;

  static SendMessagesService get instance {
    if (SendMessagesService._instance == null)
      SendMessagesService._instance = SendMessagesService();
    return SendMessagesService._instance!;
  }

  FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  Stream<PlayerModel?> _player$ = CurrentPlayerService.instance.player$;

  Stream<bool> text$(ChatModel chat, String text) {
    return this._player$.take(1).asyncMap<bool>((user) async {
      if (user == null) return false;

      final TextMessageModel message = TextMessageModel(
        id: _generateId(),
        senderId: user.uid,
        text: text,

        /// TODO: use FieldValue.serverTimestamp()
        sendedDate: DateTime.now(),
        sender: ChatParticipantModel(
          displayName: user.displayName,
          uid: user.uid,
        ),
      );
      final DocumentReference<Map<String, dynamic>> messagesDoc = this
          ._fFirestore
          .collection('chats')
          .doc(chat.id)
          .collection('messages')
          .doc(message.id);

      /// send message
      try {
        await messagesDoc.set(message.toMap());
        return true;
      } catch (e) {
        print(e);
        return false;
      }
    });
  }

  String _generateId({int size = 10}) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    String id = String.fromCharCodes(
      Iterable.generate(
        size,
        (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length)),
      ),
    );
    return id;
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
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

  Stream<bool> text$(ChatModel chat, String content) {
    return this._sendMessage(
      chat: chat,
      createMessageCallback: (user) => TextMessageModel(
        id: _generateId(),
        senderId: user.uid,
        text: content,

        /// TODO: use FieldValue.serverTimestamp()
        sendedDate: DateTime.now(),
        sender: ChatParticipantModel(
          displayName: user.displayName,
          uid: user.uid,
        ),
      ),
    );
  }

  Stream<bool> image$(ChatModel chat, ImageDto image) {
    return this._sendMessage(
      chat: chat,
      createMessageCallback: (user) => ImageMessageModel(
        id: _generateId(),
        senderId: user.uid,
        image: image,

        /// TODO: use FieldValue.serverTimestamp()
        sendedDate: DateTime.now(),
        sender: ChatParticipantModel(
          displayName: user.displayName,
          uid: user.uid,
        ),
      ),
    );
  }

  Stream<bool> video$(ChatModel chat, VideoDto videoDto) {
    return this._sendMessage(
      chat: chat,
      createMessageCallback: (user) => VideoMessageModel(
        id: _generateId(),
        senderId: user.uid,
        video: videoDto,

        /// TODO: use FieldValue.serverTimestamp()
        sendedDate: DateTime.now(),
        sender: ChatParticipantModel(
          displayName: user.displayName,
          uid: user.uid,
        ),
      ),
    );
  }

  /// function that add a message to a specific chat
  Stream<bool> _sendMessage({
    required ChatModel chat,
    required MessageModel Function(PlayerModel) createMessageCallback,
  }) {
    return this._player$.take(1).asyncMap<bool>(
      (user) async {
        if (user == null) return false;

        /// create message to send
        MessageModel newMessage = createMessageCallback(user);
        final DocumentReference<Map<String, dynamic>> messagesDoc = this
            ._fFirestore
            .collection('chats')
            .doc(chat.id)
            .collection('messages')
            .doc(newMessage.id);

        /// send message
        try {
          await messagesDoc.set(newMessage.toMap());
          return true;
        } catch (e) {
          print(e);
          return false;
        }
      },
    );
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

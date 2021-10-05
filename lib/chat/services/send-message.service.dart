import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/chats/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:lab_movil_2222/shared/pipes/random-string.extencion.dart';
import 'package:provider/provider.dart';

class SendMessagesService {
  SendMessagesService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance,
        _random = Random();

  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;

  final Random _random;

  Stream<bool> text$(ChatModel chat, String content) {
    return _sendMessage(
      chat: chat,
      createMessageCallback: (user) => TextMessageModel(
        id: _random.generateString(),
        senderId: user.uid,
        text: content,
        sendedDate: DateTime.now(),
        sender: ChatParticipantModel(
          displayName: user.displayName,
          uid: user.uid,
        ),
      ),
    );
  }

  Stream<bool> image$(ChatModel chat, ImageDto image) {
    return _sendMessage(
      chat: chat,
      createMessageCallback: (user) => ImageMessageModel(
        id: _random.generateString(),
        senderId: user.uid,
        image: image,
        sendedDate: DateTime.now(),
        sender: ChatParticipantModel(
          displayName: user.displayName,
          uid: user.uid,
        ),
      ),
    );
  }

  Stream<bool> video$(ChatModel chat, VideoDto videoDto) {
    return _sendMessage(
      chat: chat,
      createMessageCallback: (user) => VideoMessageModel(
        id: _random.generateString(),
        senderId: user.uid,
        video: videoDto,
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
    return _currentPlayerService.player$.take(1).asyncMap<bool>(
      (user) async {
        if (user == null) {
          return false;
        }

        /// create message to send
        final MessageModel newMessage = createMessageCallback(user);
        final DocumentReference<Map<String, dynamic>> messagesDoc = _fFirestore
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
}

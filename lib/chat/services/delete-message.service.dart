import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';

class DeleteMessageService {
  DeleteMessageService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance;

  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;

  /// function that delete a message of the own user
  Stream<bool> deleteMessage$({
    required ChatModel chat,
    required MessageModel message,
  }) {
    return _currentPlayerService.player$.take(1).asyncMap<bool>(
      (user) async {
        if (user == null) {
          return false;
        }

        /// creates a deleted message from deletedMessageModel
        final MessageModel deletedMessage = DeletedMessageModel(
            id: message.id,
            senderId: message.senderId,
            sendedDate: message.sendedDate,
            sender: message.sender);

        final DocumentReference<Map<String, dynamic>> messagesDoc = _fFirestore
            .collection('chats')
            .doc(chat.id)
            .collection('messages')
            .doc(message.id);

        /// deletes the message
        try {
          await messagesDoc.update(deletedMessage.toMap());
          return true;
        } catch (e) {
          print(e);
          return false;
        }
      },
    );
  }
}

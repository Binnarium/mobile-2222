import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  Stream<bool> text$(ChatModel chat, dynamic content, String kind) {
    print('entró al servicio text');
    dynamic message;
    print('content: $content');
    return this._player$.take(1).asyncMap<bool>(
      (user) async {
        print('user null? : $user');
        if (user == null) return false;
        print('user no es null');
        if (kind == "MESSAGE#TEXT") {
          print("ES MENSAJE: $content");

          message = TextMessageModel(
            id: _generateId(),
            senderId: user.uid,
            text: content,

            /// TODO: use FieldValue.serverTimestamp()
            sendedDate: DateTime.now(),
            sender: ChatParticipantModel(
              displayName: user.displayName,
              uid: user.uid,
            ),
          );
        }
        if (kind == "MESSAGE#IMAGE") {
          print("ES IMAGEDTO $content");
          ImageDto imageDto = content;

          /// send image message
          message = ImageMessageModel(
              id: _generateId(),
              senderId: user.uid,
              sendedDate: DateTime.now(),
              sender: ChatParticipantModel(
                displayName:
                    (user.displayName != '') ? user.displayName : user.email,
                uid: user.uid,
              ),
              kind: "MESSAGE#IMAGE",
              image: imageDto);
          print(message.toMap());
        }
        if (content is VideoDto) {
          print('Es VIDEODTO $content');
        }

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
      },
    );
  }

  /// a testing using streams, doesn't reach the return line code, only reaches
  /// the print('image name: ${image.name}');

  // Stream<bool> image$(ChatModel chat, ImageDto image, String kind) {
  //   print('entró al servicio image');
  //   print('image name: ${image.name}');
  //   return this._player$.take(1).asyncMap<bool>(
  //     (user) async {
  //       print('user null? : $user');
  //       if (user == null) return false;
  //       print('user no es null');

  //       /// send image message
  //       ImageMessageModel message = ImageMessageModel(
  //           id: _generateId(),
  //           senderId: user.uid,
  //           sendedDate: DateTime.now(),
  //           sender: ChatParticipantModel(
  //             displayName:
  //                 (user.displayName != '') ? user.displayName : user.email,
  //             uid: user.uid,
  //           ),
  //           kind: "MESSAGE#IMAGE",
  //           image: image);
  //       final DocumentReference<Map<String, dynamic>> messagesDoc = this
  //           ._fFirestore
  //           .collection('chats')
  //           .doc(chat.id)
  //           .collection('messages')
  //           .doc(message.id);

  //       /// send message
  //       try {
  //         await messagesDoc.set(message.toMap());
  //         return true;
  //       } catch (e) {
  //         print(e);
  //         return false;
  //       }
  //     },
  //   );
  // }
  /// a method to upload multimedia to the chat
  Future<void> multimedia(ChatModel chat, dynamic content, String kind) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    String displayName = FirebaseAuth.instance.currentUser!.displayName!;
    String email = FirebaseAuth.instance.currentUser!.email!;
    dynamic message;

    if (kind == "MESSAGE#IMAGE") {
      /// send image message
      message = ImageMessageModel(
          id: _generateId(),
          senderId: uid,
          sendedDate: DateTime.now(),
          sender: ChatParticipantModel(
            displayName: (displayName != '') ? displayName : email,
            uid: uid,
          ),
          kind: kind,
          image: content);
    } else if (kind == "MESSAGE#VIDEO") {
      /// send video message
      message = VideoMessageModel(
          id: _generateId(),
          senderId: uid,
          sendedDate: DateTime.now(),
          sender: ChatParticipantModel(
            displayName: (displayName != '') ? displayName : email,
            uid: uid,
          ),
          kind: kind,
          video: content);
    }

    final DocumentReference<Map<String, dynamic>> messagesDoc = this
        ._fFirestore
        .collection('chats')
        .doc(chat.id)
        .collection('messages')
        .doc(message.id);

    /// send message
    try {
      await messagesDoc.set(message.toMap());
    } catch (e) {
      print(e);
    }
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

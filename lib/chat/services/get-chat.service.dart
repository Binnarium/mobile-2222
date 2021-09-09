import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:rxdart/rxdart.dart';

class GetChatService {
  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  final Stream<PlayerModel?> _currentPlayer$ =
      CurrentPlayerService.instance.player$;

  Future<ChatModel?> getChat(String chatId) {
    return this._currentPlayer$.take(1).switchMap((user) {
      if (user == null) return Stream.value(null);

      /// get collection of users
      final chatsDoc = this._fFirestore.collection('chats').doc(chatId);
      return chatsDoc
          .snapshots()

          /// obtain docs of payload
          .map((snapshot) => snapshot.exists ? snapshot.data() : null)

          /// map data to instances of chat
          .map(
            (data) => data == null
                ? null
                : ChatModel(
                    id: data['id'],
                    kind: data['kind'],
                    disabled: data['disabled'],
                    participantsCompleted:
                        data['participantsCompleted'] == true,
                    name: data['name'] ?? null,
                    lastActivity: (data['lastActivity'] as Timestamp).toDate(),
                    indexedDate: (data['indexedDate'] as Timestamp?)?.toDate(),
                    participants:
                        ((data['participants'] ?? []) as List<dynamic>)
                            .map((e) => ChatParticipantModel.fromMap(e))
                            .toList(),
                    participantsUids:
                        (data['participantsUids'] as List<dynamic>)
                            .map((e) => e.toString())
                            .toList(),
                    lastMessage: data['lastMessage'] == null
                        ? null
                        : MessageModel.fromMap(
                            data['lastMessage'],
                            currentUid: user.uid,
                          ),
                  ),
          );
    }).first;
  }
}

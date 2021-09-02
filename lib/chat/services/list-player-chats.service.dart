import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lab_movil_2222/chat/models/chat-participant.model.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';
import 'package:lab_movil_2222/chat/models/message.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:rxdart/rxdart.dart';

class ListPlayerChatsService {
  static ListPlayerChatsService? _instance;

  ListPlayerChatsService._();

 static ListPlayerChatsService get instance {
    if (ListPlayerChatsService._instance == null)
      ListPlayerChatsService._instance = ListPlayerChatsService._();
    return ListPlayerChatsService._instance!;
  }

  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  final Stream<PlayerModel?> _currentPlayer$ =
      CurrentPlayerService.instance.player$;

  Stream<List<ChatModel>> get chats$ => this._currentPlayer$.switchMap((user) {
        if (user == null) return Stream.value([]);

        /// get collection of users
        final chatsCollection = this
            ._fFirestore
            .collection('chats')
            .where('participantsUids', arrayContains: user.uid);
        return chatsCollection
            .snapshots()

            /// obtain docs of payload
            .map((snapshot) => snapshot.docs.map((e) => e.data()).toList())

            /// map data to instances of chat
            .map(
              (docs) => docs
                  .map((data) => ChatModel(
                        id: data['id'],
                        disabled: data['disabled'],
                        participantsCompleted:
                            data['participantsCompleted'] == true,
                        name: data['name'] ?? null,
                        lastActivity:
                            (data['lastActivity'] as Timestamp).toDate(),
                        indexedDate:
                            (data['indexedDate'] as Timestamp?)?.toDate(),
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
                      ))
                  .toList(),
            );
      });
  // Stream<List<ChatModel>> get chats$ => this
  //     ._currentPlayer$

  //     /// query to player chats
  //     .map((user) => user == null
  //         ? null
  //         : this
  //             ._fFirestore
  //             .collection('chats')
  //             .where('participantsUids', arrayContains: user.uid))

  //     /// obtain snapshots of players
  //     .switchMap(
  //         (query) => query == null ? Stream.value(null) : query.snapshots())

  //     /// obtain docs of payload
  //     .map((snapshot) => snapshot?.docs.map((e) => e.data()).toList() ?? [])

  //     /// map data to instances of chat
  //     .map(
  //       (docs) => docs
  //           .map((data) => ChatModel(
  //               id: data['id'],
  //               disabled: data['disabled'],
  //               participantsCompleted: data['participantsCompleted'] == true,
  //               name: data['name'] ?? null,
  //               lastActivity: (data['lastActivity'] as Timestamp).toDate(),
  //               indexedDate: (data['indexedDate'] as Timestamp?)?.toDate(),
  //               participants: ((data['participants'] ?? []) as List<dynamic>)
  //                   .map((e) => ChatParticipantModel.fromMap(e))
  //                   .toList(),
  //               participantsUids: (data['participantsUids'] as List<dynamic>)
  //                   .map((e) => e.toString())
  //                   .toList(),
  //               lastMessage: data['lastMessage'] == null
  //                   ? null
  //                   : MessageModel.fromMap(data['lastMessage'], currentUid: '')))
  //           .toList(),
  //     );
}

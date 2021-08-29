import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/chat/models/chat.model.dart';

class ListPlayerChatsService {
  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  /// TODO: use player service instead
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  static ListPlayerChatsService? _instance;

  ListPlayerChatsService._();

  factory ListPlayerChatsService() {
    if (ListPlayerChatsService._instance == null)
      ListPlayerChatsService._instance = ListPlayerChatsService._();
    return ListPlayerChatsService._instance!;
  }

  Stream<List<ChatModel>> get getChats => this
      ._fFirestore
      .collection('chats')
      .where('participantsUids', arrayContains: this._fAuth.currentUser!.uid)
      .snapshots()
      .map((snapshot) => snapshot.docs)
      .map((docs) => docs.map((e) => ChatModel.fromMap(e.data())).toList());
}

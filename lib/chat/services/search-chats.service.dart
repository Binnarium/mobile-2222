import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/chat/models/search-chat-query.model%20copy.dart';
import 'package:lab_movil_2222/chat/models/search-chat-response.model.dart';

class SearchChatsService {
  final FirebaseFunctions _fFunctions = FirebaseFunctions.instance;
  final FirebaseAuth _fAuth = FirebaseAuth.instance;

  Future<List<SearchChatResponseModel>?> search(String value) async {
    HttpsCallable searchPlayers = this._fFunctions.httpsCallable('searchChat');

    final SearchChatQueryModel query = SearchChatQueryModel(
      playerId: this._fAuth.currentUser!.uid,
      query: value,
    );

    final response = await searchPlayers<String>(query.toMap());

    final List<Map<String, dynamic>>? data =
        (jsonDecode(response.data) as List<dynamic>)
            .map((e) => e as Map<String, dynamic>)
            .toList();

    List<SearchChatResponseModel>? searchChatsResults =
        data?.map((e) => SearchChatResponseModel.fromMap(e)).toList();

    return searchChatsResults;
  }
}

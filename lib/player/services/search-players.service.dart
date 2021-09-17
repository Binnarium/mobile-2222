import 'dart:convert';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:lab_movil_2222/player/models/player-search-query.model.dart';
import 'package:lab_movil_2222/player/models/player-search-result.model.dart';

class SearchPlayersService {
  final FirebaseFunctions _fFunctions = FirebaseFunctions.instance;

  Future<List<SearchPlayerResultModel>?> search(
      PlayerSearchQueryModel query) async {
    HttpsCallable searchPlayers = _fFunctions.httpsCallable('searchPlayer');

    final response = await searchPlayers<String>(query.toMap());

    final List<Map<String, dynamic>>? data =
        (jsonDecode(response.data) as List<dynamic>)
            .map((dynamic e) => e as Map<String, dynamic>)
            .toList();

    List<SearchPlayerResultModel>? searchChatsResults = data
        ?.map(
          (e) => SearchPlayerResultModel.fromMap(e),
        )
        .toList();

    return searchChatsResults;
  }
}

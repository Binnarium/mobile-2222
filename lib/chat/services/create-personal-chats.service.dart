import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/models/create-personal-chat-query.model.dart';
import 'package:lab_movil_2222/chat/models/create-personal-chat-response.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';

class CreatePersonalChatService {
  final FirebaseFunctions _functions;
  final CurrentPlayerService _currentPlayerService;

  CreatePersonalChatService(BuildContext context)
      : this._functions = FirebaseFunctions.instance,
        this._currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false);

  Stream<CreatePersonalChatResponseModel> create$(String otherPlayerId) {
    HttpsCallable createPersonalChat =
        _functions.httpsCallable('createPersonalChat');

    return this._currentPlayerService.player$.take(1).asyncMap(
      (currentPlayer) async {
        if (currentPlayer == null)
          return CreatePersonalChatResponseModel(chatId: null);

        final CreatePersonalChatQueryModel query = CreatePersonalChatQueryModel(
          playerOne: currentPlayer.uid,
          playerTwo: otherPlayerId,
        );

        final response = await createPersonalChat<String?>(query.toMap());

        return CreatePersonalChatResponseModel(chatId: response.data);
      },
    );
  }
}

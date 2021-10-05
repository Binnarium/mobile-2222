import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/chat/chats/models/create-personal-chat.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:provider/provider.dart';

class CreatePersonalChatService {
  /// constructor
  CreatePersonalChatService(BuildContext context)
      : _functions = FirebaseFunctions.instance,
        _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false);

  /// params
  final FirebaseFunctions _functions;
  final CurrentPlayerService _currentPlayerService;

  Stream<CreatePersonalChatResponseModel> create$(String otherPlayerId) {
    final HttpsCallable createPersonalChat =
        _functions.httpsCallable('createPersonalChat');

    return _currentPlayerService.player$.take(1).asyncMap(
      (currentPlayer) async {
        if (currentPlayer == null) {
          return CreatePersonalChatResponseModel(chatId: null);
        }

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

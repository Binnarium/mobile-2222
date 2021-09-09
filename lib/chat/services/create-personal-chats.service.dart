import 'package:cloud_functions/cloud_functions.dart';
import 'package:lab_movil_2222/chat/models/create-personal-chat-query.model.dart';
import 'package:lab_movil_2222/chat/models/create-personal-chat-response.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';

class CreatePersonalChatService {
  final FirebaseFunctions _fFunctions = FirebaseFunctions.instance;
  final CurrentPlayerService _currentPlayerService =
      CurrentPlayerService.instance;

  Stream<CreatePersonalChatResponseModel> create$(String otherPlayerId) {
    HttpsCallable createPersonalChat =
        this._fFunctions.httpsCallable('createPersonalChat');
    return this._currentPlayerService.player$.take(1).asyncMap((player) async {
      if (player == null) return CreatePersonalChatResponseModel(chatId: null);

      final CreatePersonalChatQueryModel query = CreatePersonalChatQueryModel(
        playerOne: player.uid,
        playerTwo: otherPlayerId,
      );

      final response = await createPersonalChat<String?>(query.toMap());

      return CreatePersonalChatResponseModel(chatId: response.data);
    });
  }
}

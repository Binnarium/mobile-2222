import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';

class LoadPlayerInformationService {
  @Deprecated('do not use this implementation')
  Future<PlayerModel> loadInformation(String userUID) async {
    final payload = await FirebaseFirestore.instance
        .collection('players')
        .doc(userUID)
        .get();

    if (!payload.exists)
      throw new ErrorDescription('Player information not found');
    return PlayerModel.fromMap(payload.data()!);
  }
}

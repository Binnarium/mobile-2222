import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/models/player.dto.dart';

class LoadPlayerInformationService {
  // Future<PlayerDto> loadProject(String userUID, String cityName) async {
  //   final payload = await FirebaseFirestore.instance
  //       .collection('players')
  //       .doc(userUID)
  //       .collection('project')
  //       .doc(cityName)
  //       .get();

  //   if (!payload.exists)
  //     throw new ErrorDescription('Player $userUID Project not found');
  //   return PlayerDto.fromMap(payload.data()!);
  // }

  Future<dynamic> loadInformation(String userUID) async {
    final payload = await FirebaseFirestore.instance
        .collection('players')
        .doc(userUID)
        .get();

    if (!payload.exists)
      throw new ErrorDescription('Player information not found');
    return PlayerDto.fromMap(payload.data()!);
  }
}

import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/create-clubhouse.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:lab_movil_2222/shared/pipes/random-string.extencion.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CreateClubhouseService {
  CreateClubhouseService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance;

  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;

  Stream<bool> create$({required CityModel city, required String url}) {
    final PlayerModel? currentPlayer = _currentPlayerService.currentPlayer;

    if (currentPlayer == null) return Stream.value(false);

    final CreateClubhouseModel createClubhouseModel = CreateClubhouseModel(
      cityId: city.id,
      clubhouseUrl: url,
      id: Random().generateString(size: 15),
      uploaderId: currentPlayer.uid,
    );

    return _fFirestore
        .collection('players')
        .doc(currentPlayer.uid)
        .collection('clubhouse')
        .doc(createClubhouseModel.id)
        .set(createClubhouseModel.toMap())
        .asStream()
        .mapTo(true);
  }
}

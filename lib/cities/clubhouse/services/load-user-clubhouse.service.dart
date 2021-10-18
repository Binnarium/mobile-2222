import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LoadUserClubhouseService {
  /// constructor
  LoadUserClubhouseService(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _fFirestore = FirebaseFirestore.instance;

  /// params
  final CurrentPlayerService _currentPlayerService;

  final FirebaseFirestore _fFirestore;

  Stream<List<ClubhouseModel>> load$(CityModel city) {
    return _currentPlayerService.player$.switchMap(
      (user) {
        if (user == null) {
          return Stream.value([]);
        }

        final Query<Map<String, dynamic>> query = _fFirestore
            .collection('clubhouse')
            .where('cityId', isEqualTo: city.id)
            .where('uploaderId', isEqualTo: user.uid)
            .orderBy('date', descending: false);

        final Stream<List<ClubhouseModel>> stream = query.snapshots().map(
              (payload) => payload.docs
                  .map((doc) => doc.data())
                  .map((doc) => ClubhouseModel.fromMap(doc))
                  .toList(),
            );
        return stream;
      },
    );
  }
}

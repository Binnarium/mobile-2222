import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/project/models/player-projects.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/services/current-player.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LoadProjectFiles {
  LoadProjectFiles(BuildContext context)
      : _currentPlayerService =
            Provider.of<CurrentPlayerService>(context, listen: false),
        _firestore = FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  final CurrentPlayerService _currentPlayerService;

  Stream<List<PlayerProject>> load$(CityModel city) {
    return _currentPlayerService.player$.switchMap((user) {
      if (user == null) {
        return Stream.value([]);
      }

      final Query<Map<String, dynamic>> query =
          _firestore.collection('players').doc(user.uid).collection('project');

      return query
          .snapshots()
          .map(
            (payload) => payload.docs
                .map((doc) => doc.data())
                .map((data) => PlayerProject.fromMap(data))
                .toList(),
          )
          .startWith([]);
    });
  }
}

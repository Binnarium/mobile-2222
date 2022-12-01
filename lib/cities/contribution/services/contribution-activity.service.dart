import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/contribution/models/contribution.model.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/models/city-history.dto.dart';
import 'package:lab_movil_2222/services/load-city-history.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ContributionActivityService {
  ContributionActivityService(BuildContext context)
      : _firestore = FirebaseFirestore.instance,
        _historyService =
            Provider.of<LoadCityHistoryService>(context, listen: false);

  final FirebaseFirestore _firestore;
  final LoadCityHistoryService _historyService;

  Stream<CollaborationModel?> explanation$(CityModel city) {
    final Stream<Map<String, dynamic>?> contributionData = _firestore
        .collection('cities')
        .doc(city.id)
        .collection('pages')
        .doc('contribution')
        .snapshots()

        /// turn snapshot into document data or null
        .map((snapshot) => snapshot.data());

    /// to get the thematic of the city, then obtain it from the history of the city
    final Stream<String> thematic = _historyService.load$(city).take(1).map(
      (event) {
        final TitleHistoryDto? title = event?.content
                .firstWhere((element) => element.runtimeType == TitleHistoryDto)
            as TitleHistoryDto?;
        return title?.title ?? city.name;
      },
    );

    return Rx.combineLatest2(
      contributionData,
      thematic,
      (Map<String, dynamic>? data, String thematic) => data == null
          ? null
          : CollaborationModel.fromMap(data, thematic: thematic),
    );
  }
}

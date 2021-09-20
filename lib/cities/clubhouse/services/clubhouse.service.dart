import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-activity.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/city-history.dto.dart';
import 'package:lab_movil_2222/services/load-city-history.service.dart';
import 'package:provider/provider.dart';

class ClubhouseActivityService {
  ClubhouseActivityService(BuildContext context)
      : _historyService =
            Provider.of<LoadCityHistoryService>(context, listen: false);

  final LoadCityHistoryService _historyService;

  Stream<ClubhouseActivityModel> activity$(CityModel city) {
    /// to get the thematic of the city, then obtain it from the history of the city
    final Stream<String> thematic = _historyService.load$(city).take(1).map(
      (event) {
        final TitleHistoryDto? title = event?.content
                .firstWhere((element) => element.runtimeType == TitleHistoryDto)
            as TitleHistoryDto?;
        return title?.title ?? city.name;
      },
    );

    return thematic.map((event) => ClubhouseActivityModel(thematic: event));
    ;
  }
}

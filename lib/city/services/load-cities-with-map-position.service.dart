import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city-with-map-position.model.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/city/services/cities.service.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CitiesMapPositionsService {
  final CitiesService _citiesService;

  CitiesMapPositionsService(BuildContext context)
      : _citiesService = Provider.of<CitiesService>(context, listen: false);

  Stream<List<CityWithMapPositionModel>> get load$ => _citiesService.allCities$
      .map((event) => _addCitiesPositions(event))
      .shareReplay();

  List<CityWithMapPositionModel> _addCitiesPositions(List<CityModel> cities) {
    return cities
        .asMap()
        .map((index, city) {
          int top = 0;
          int left = 0;
          int size = 12;
          bool textOnTop = false;

          /// calculate pos
          if (index == 0) {
            top = 80;
            left = 30;
          } else if (index == 1) {
            top = 68;
            left = 15;
          } else if (index == 2) {
            top = 75;
            left = 59;
          } else if (index == 3) {
            top = 65;
            left = 80;
          } else if (index == 4) {
            top = 58;
            left = 45;
            textOnTop = true;
          } else if (index == 5) {
            top = 50;
            left = 8;
          } else if (index == 6) {
            top = 35;
            left = 24;
          } else if (index == 7) {
            top = 42;
            left = 61;
          } else if (index == 8) {
            top = 30;
            left = 76;
          } else if (index == 9) {
            top = 23;
            left = 46;
          } else if (index == 10) {
            top = 17;
            left = 14;
          } else if (index == 11) {
            top = 4;
            left = 45;
          }

          final CityWithMapPositionModel cityWithPosition =
              CityWithMapPositionModel(
            city: city,
            top: top,
            left: left,
            size: size,
            textOnTop: textOnTop,
          );

          return MapEntry(index, cityWithPosition);
        })
        .values
        .toList();
  }
}

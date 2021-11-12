import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/asset.dto.dart';
import 'package:lab_movil_2222/city/models/city-configuration.model.dart';
import 'package:lab_movil_2222/city/models/city-enabled-pages.model.dart';

class CityModel {
  /// constructor
  CityModel.fromMap(final Map<String, dynamic> payload)
      : id = payload['id'] as String,
        name = payload['name'] as String,
        stage = payload['stage'] as int,
        configuration = CityConfigurationModel.fromMap(
            payload['configuration'] as Map<String, dynamic>),
        enabledPages = CityEnabledPagesModel.fromMap(
            payload['enabledPages'] as Map<String, dynamic>),
        icon = ImageDto.fromMap(payload['icon'] as Map<String, dynamic>),
        iconMap = ImageDto.fromMap(payload['iconMap'] as Map<String, dynamic>),
        nextCity = null;

  final String id;
  final String name;
  final int stage;
  final ImageDto icon;
  final ImageDto iconMap;
  final CityConfigurationModel configuration;
  final CityEnabledPagesModel enabledPages;

  CityModel? nextCity;

  void addNextCity(CityModel next) => nextCity = next;

  Color get color => Color(configuration.colorHex);

  ImageProvider get iconImage => NetworkImage(icon.url);
  ImageProvider get iconMapImage => NetworkImage(iconMap.url);

  String get phaseName => 'Etapa $stage'.toUpperCase();

  String get imageTag => 'city-image-$id'.toLowerCase();
}

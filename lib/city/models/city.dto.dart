import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city-configuration.model.dart';
import 'package:lab_movil_2222/city/models/city-enabled-pages.model.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class CityModel {
  final String id;
  final String name;
  final int stage;
  final ImageDto icon;
  final ImageDto iconMap;
  final CityConfigurationModel configuration;
  final CityEnabledPagesModel enabledPages;

  CityModel? nextCity;

  CityModel.fromMap(final Map<String, dynamic> payload)
      : this.id = payload['id'],
        this.name = payload['name'] as String,
        this.stage = payload['stage'] as int,
        this.configuration =
            CityConfigurationModel.fromMap(payload['configuration']),
        this.enabledPages =
            CityEnabledPagesModel.fromMap(payload['enabledPages']),
        this.icon = ImageDto.fromMap(payload['icon']),
        this.iconMap = ImageDto.fromMap(payload['iconMap']),
        this.nextCity = null;

  void addNextCity(CityModel next) => this.nextCity = next;

  Color get color => Color(this.configuration.colorHex);

  @Deprecated('use icon.url instead, or iconImage')
  String get chapterImageUrl => this.icon.url;

  ImageProvider get iconImage => NetworkImage(this.icon.url);
  ImageProvider get iconMapImage => NetworkImage(this.iconMap.url);

  get phaseName => 'Etapa ${this.stage}'.toUpperCase();

  get imageTag => 'city-image-${this.id}'.toLowerCase();
}

import 'package:flutter/material.dart';

import 'asset.dto.dart';

class _CityConfigurationDto {
  final int colorHex;

  _CityConfigurationDto.fromMap(final Map<String, dynamic> payload)
      : this.colorHex = payload['colorHex'];
}

class CityEnabledPagesDto {
  final bool activities;
  final bool questionary;
  final bool clubhouse;
  final bool project;

  CityEnabledPagesDto.fromMap(final Map<String, dynamic> payload)
      : this.activities = payload['activities'] ?? false,
        this.questionary = payload['questionary'] ?? false,
        this.clubhouse = payload['clubhouse'] ?? false,
        this.project = payload['project'] ?? false;
}

class CityDto {
  final String id;
  final String name;
  final int stage;
  final ImageDto icon;
  final ImageDto iconMap;
  final _CityConfigurationDto configuration;
  final CityEnabledPagesDto enabledPages;
  CityDto? nextCity;

  CityDto.fromMap(final Map<String, dynamic> payload)
      : this.id = payload['id'],
        this.name = payload['name'] as String,
        this.stage = payload['stage'] as int,
        this.configuration =
            _CityConfigurationDto.fromMap(payload['configuration']),
        this.enabledPages =
            CityEnabledPagesDto.fromMap(payload['enabledPages']),
        this.icon = ImageDto.fromMap(payload['icon']),
        this.iconMap = ImageDto.fromMap(payload['iconMap']),
        this.nextCity = null;

  void addNextCity(CityDto next) => this.nextCity = next;

  Color get color => Color(this.configuration.colorHex);

  @Deprecated('use icon.url instead, or iconImage')
  String get chapterImageUrl => this.icon.url;

  ImageProvider get iconImage => NetworkImage(this.icon.url);
  ImageProvider get iconMapImage => NetworkImage(this.iconMap.url);

  get phaseName => 'Etapa ${this.stage}'.toUpperCase();

  get imageTag => 'city-image-${this.id}'.toLowerCase();
}

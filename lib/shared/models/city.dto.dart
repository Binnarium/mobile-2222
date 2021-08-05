import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/models/image.dto.dart';

class CityConfigurationDto {
  final int colorHex;

  CityConfigurationDto.fromMap(final Map<String, dynamic> payload)
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
  final CityConfigurationDto configuration;
  final CityEnabledPagesDto enabledPages;

  const CityDto({
    required this.id,
    required this.name,
    required this.stage,
    required this.enabledPages,
    required this.configuration,
    required this.icon,
    required this.iconMap,
  });

  CityDto.fromMap(final Map<String, dynamic> payload)
      : this.id = payload['id'],
        this.name = payload['name'] as String,
        this.stage = payload['stage'] as int,
        this.configuration =
            CityConfigurationDto.fromMap(payload['configuration']),
        this.enabledPages =
            CityEnabledPagesDto.fromMap(payload['enabledPages']),
        this.icon = ImageDto.fromMap(payload['icon']),
        this.iconMap = ImageDto.fromMap(payload['iconMap']);

  Color get color => Color(this.configuration.colorHex);

  @Deprecated('use icon.url instead')
  String get chapterImageUrl => this.icon.url;

  ImageProvider get iconImage => NetworkImage(this.icon.url);
  ImageProvider get iconMapImage => NetworkImage(this.iconMap.url);

  get phaseName => 'Etapa ${this.stage}';
}

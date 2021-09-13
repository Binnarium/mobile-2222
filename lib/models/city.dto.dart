import 'package:flutter/material.dart';

import 'asset.dto.dart';

class _CityConfigurationDto {
  final int colorHex;

  _CityConfigurationDto.fromMap(final Map<String, dynamic> payload)
      : this.colorHex = payload['colorHex'];
}

class CityEnabledPagesDto {
  final bool resources;
  final bool introductoryVideo;
  final bool argumentation;
  final bool manualVideo;
  final bool projectVideo;
  final bool microMesoMacro;
  final bool finalVideo;
  final bool content;

  /// activities
  final bool activities;
  final bool contribution;
  final bool contributionExplanation;
  final bool clubhouse;
  final bool clubhouseExplanation;
  final bool project;
  final bool hackatonMedals;

  CityEnabledPagesDto.fromMap(final Map<String, dynamic> payload)
      : this.activities = payload['activities'] == true,
        this.contribution = payload['contribution'] == true,
        this.contributionExplanation =
            payload['contributionExplanation'] == true,
        this.clubhouseExplanation = payload['clubhouseExplanation'] == true,
        this.clubhouse = payload['clubhouse'] == true,
        this.resources = payload['resources'] == true,
        this.introductoryVideo = payload['introductoryVideo'] == true,
        this.argumentation = payload['argumentation'] == true,
        this.manualVideo = payload['manualVideo'] == true,
        this.projectVideo = payload['projectVideo'] == true,
        this.content = payload['content'] == true,
        this.microMesoMacro = payload['microMesoMacro'] == true,
        this.finalVideo = payload['finalVideo'] == true,
        this.project = payload['project'] == true,
        this.hackatonMedals = payload['hackatonMedals'] == true;

  bool get enableClubhouseRoutes => this.clubhouse || this.clubhouseExplanation;
  bool get enableContributionRoutes =>
      this.contribution || this.contributionExplanation;
  bool get enableProjectRoutes => this.project || this.projectVideo;
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

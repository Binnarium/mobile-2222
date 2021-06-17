// To parse this JSON data, do
//
//     final chapterSettings = chapterSettingsFromJson(jsonString);

import 'dart:convert';

Map<String, ChapterSettings> chapterSettingsFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, ChapterSettings>(k, ChapterSettings.fromJson(v)));

String chapterSettingsToJson(Map<String, ChapterSettings> data) => json.encode(
    Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class ChapterSettings {
  ChapterSettings({
    required this.primaryColor,
    required this.phaseName,
    required this.cityName,
    required this.chapterImageUrl,
    required this.decoration1Url,
    required this.characterImageUrl,
  });

  String primaryColor;
  String phaseName;
  String cityName;
  String chapterImageUrl;
  String decoration1Url;
  String characterImageUrl;

  factory ChapterSettings.fromJson(Map<String, dynamic> json) =>
      ChapterSettings(
        primaryColor: json["primaryColor"],
        phaseName: json["phaseName"],
        cityName: json["cityName"],
        chapterImageUrl: json["chapterImageURL"],
        decoration1Url: json["decoration1URL"],
        characterImageUrl: json["characterImageURL"],
      );

  Map<String, dynamic> toJson() => {
        "primaryColor": primaryColor,
        "phaseName": phaseName,
        "cityName": cityName,
        "chapterImageURL": chapterImageUrl,
        "decoration1URL": decoration1Url,
        "characterImageURL": characterImageUrl,
      };
}

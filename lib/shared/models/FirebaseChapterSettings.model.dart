// To parse this JSON data, do
//
//     final chapterSettings = chapterSettingsFromJson(jsonString);

import 'dart:convert';

Map<String, FirebaseChapterSettings> chapterSettingsFromJson(String str) =>
    Map.from(json.decode(str)).map((k, v) =>
        MapEntry<String, FirebaseChapterSettings>(
            k, FirebaseChapterSettings.fromJson(v)));

String chapterSettingsToJson(Map<String, FirebaseChapterSettings> data) =>
    json.encode(
        Map.from(data).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())));

class FirebaseChapterSettings {
  FirebaseChapterSettings({
    required this.id,
    required this.primaryColor,
    required this.phaseName,
    required this.cityName,
    required this.chapterImageUrl,
  });

  String id;
  int primaryColor;
  String phaseName;
  String cityName;
  String chapterImageUrl;

  factory FirebaseChapterSettings.fromJson(Map<String, dynamic> json) =>
      FirebaseChapterSettings(
        id: json["id"],
        primaryColor: json["configuration"]["colorHex"],
        phaseName: "etapa " + json["stage"].toString(),
        cityName: json["name"],
        chapterImageUrl: json["iconUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "primaryColor": primaryColor,
        "phaseName": phaseName,
        "cityName": cityName,
        "chapterImageURL": chapterImageUrl,
      };
}

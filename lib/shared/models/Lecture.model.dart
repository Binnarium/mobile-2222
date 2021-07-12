// To parse this JSON data, do
//
//     final LectureModel = LectureModelFromJson(jsonString);

import 'dart:convert';

LectureModel lectureModelFromJson(String str) =>
    LectureModel.fromJson(json.decode(str));

String lectureModelToJson(LectureModel data) => json.encode(data.toJson());

class LectureModel {
  LectureModel({
    required this.coverUrl,
    required this.author,
    required this.about,
    required this.name,
    required this.publishedDate,
    required this.id,
  });

  String coverUrl;
  String author;
  String about;
  String name;
  String publishedDate;
  String id;

  factory LectureModel.fromJson(Map<String, dynamic> json) => LectureModel(
        coverUrl: json["coverUrl"],
        author: json["author"],
        about: json["about"],
        name: json["name"],
        publishedDate: json["publishedDate"].toString(),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "coverUrl": coverUrl,
        "author": author,
        "about": about,
        "name": name,
        "publishedDate": publishedDate,
        "id": id,
      };
}

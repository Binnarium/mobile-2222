// To parse this JSON data, do
//
//     final readingModel = readingModelFromJson(jsonString);

import 'dart:convert';

ReadingModel readingModelFromJson(String str) =>
    ReadingModel.fromJson(json.decode(str));

String readingModelToJson(ReadingModel data) => json.encode(data.toJson());

class ReadingModel {
  ReadingModel({
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

  factory ReadingModel.fromJson(Map<String, dynamic> json) => ReadingModel(
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

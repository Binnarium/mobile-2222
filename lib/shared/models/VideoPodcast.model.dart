// To parse this JSON data, do
//
//     final videoPodcastModel = videoPodcastModelFromJson(jsonString);

import 'dart:convert';

VideoPodcastModel videoPodcastModelFromJson(String str) =>
    VideoPodcastModel.fromJson(json.decode(str));

String videoPodcastModelToJson(VideoPodcastModel data) =>
    json.encode(data.toJson());

class VideoPodcastModel {
  VideoPodcastModel({
    required this.duration,
    required this.path,
    required this.kind,
    this.author,
    required this.name,
    this.format,
    this.description,
    required this.title,
    required this.url,
  });

  int duration;
  String path;
  String kind;
  String? author;
  String name;
  String? format;
  String? description;
  String? title;
  String url;

  factory VideoPodcastModel.fromJson(Map<String, dynamic> json) =>
      VideoPodcastModel(
        duration: json["duration"],
        path: json["path"],
        kind: json["kind"],
        author: json["author"],
        name: json["name"],
        format: json["format"],
        description: json["description"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "duration": duration,
        "path": path,
        "kind": kind,
        "author": author,
        "name": name,
        "format": format,
        "description": description,
        "title": title,
        "url": url,
      };
}

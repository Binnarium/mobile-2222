

import 'dart:convert';

HistoryModel historyModelFromJson(String str) =>
    HistoryModel.fromJson(json.decode(str));

String historyModelToJson(HistoryModel data) => json.encode(data.toJson());

class HistoryModel {
  HistoryModel({
    this.height,
    required this.kind,
    this.name,
    this.path,
    this.url,
    this.width,
    this.title,
    this.text,
  });

  int? height;
  String kind;
  String? name;
  String? path;
  String? url;
  int? width;
  String? title;
  String? text;

  factory HistoryModel.fromJson(Map<String, dynamic> json) => HistoryModel(
        height: json["height"],
        kind: json["kind"],
        name: json["name"],
        path: json["path"],
        url: json["url"],
        width: json["width"],
        title: json["title"],
        text: json["text"],       
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "kind": kind,
        "name": name,
        "path": path,
        "url": url,
        "width": width,
        "title": title,
        "text": text,
        
        
      };
}

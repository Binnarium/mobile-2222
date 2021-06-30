// To parse this JSON data, do
//
//     final onlineResourceModel = onlineResourceModelFromJson(jsonString);

import 'dart:convert';

OnlineResourceModel onlineResourceModelFromJson(String str) =>
    OnlineResourceModel.fromJson(json.decode(str));

String onlineResourceModelToJson(OnlineResourceModel data) =>
    json.encode(data.toJson());

class OnlineResourceModel {
  OnlineResourceModel({
    required this.kind,
    required this.name,
    required this.redirect,
    required this.description,
    required this.id,
  });

  String redirect;
  String kind;
  String name;
  String description;
  String id;

  factory OnlineResourceModel.fromJson(Map<String, dynamic> json) =>
      OnlineResourceModel(
        id: json["id"],
        kind: json["kind"],
        name: json["name"],
        description: json["description"],
        redirect: json["redirect"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "kind": kind,
        "name": name,
        "description": description,
        "redirect": redirect,
      };
}

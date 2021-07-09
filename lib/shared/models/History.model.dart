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

abstract class HistoryDto {
  final String kind;

  HistoryDto({
    required this.kind,
  });

  static HistoryDto fromJson(Map<String, dynamic> payload) {
    final String kind = payload['kind'];
    if (kind == 'HISTORY#TITLE')
      return TitleHistoryDto(
        kind: kind,
        title: payload['title'],
      );
    else if (kind == 'HISTORY#TEXT')
      return TextHistoryDto(
        kind: kind,
        text: payload['text'],
      );
    else
      return ImageHistoryDto(
        kind: kind,
        url: payload['url'],
      );
  }
}

class TitleHistoryDto extends HistoryDto {
  final String? title;

  TitleHistoryDto({
    required String kind,
    this.title,
  }) : super(kind: kind);
}

class TextHistoryDto extends HistoryDto {
  final String? text;

  TextHistoryDto({
    required String kind,
    this.text,
  }) : super(kind: kind);
}

class ImageHistoryDto extends HistoryDto {
  final String? url;

  ImageHistoryDto({
    required String kind,
    this.url,
  }) : super(kind: kind);
}

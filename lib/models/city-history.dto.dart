import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class CityHistoryDto {
  final List<HistoryContentDto> content;

  CityHistoryDto.fromMap(Map<String, dynamic> payload)
      : this.content = ((payload['content'] ?? []) as List)
            .map((e) => HistoryContentDto.fromJson(e))
            .toList();
}

abstract class HistoryContentDto {
  final String kind;

  HistoryContentDto._({
    required this.kind,
  });

  static HistoryContentDto fromJson(Map<String, dynamic> payload) {
    final String kind = payload['kind'];

    if (kind == 'HISTORY#TITLE') return TitleHistoryDto._fromMap(payload);

    if (kind == 'HISTORY#TEXT') return TextHistoryDto._fromMap(payload);

    if (kind == 'HISTORY#IMAGE') return ImageHistoryDto._fromMap(payload);

    throw ErrorDescription('Invalid history content');
  }
}

class TitleHistoryDto extends HistoryContentDto {
  final String title;

  TitleHistoryDto._fromMap(Map<String, dynamic> payload)
      : this.title = payload['title'] ?? 'No title available',
        super._(kind: payload['kind']!);
}

class TextHistoryDto extends HistoryContentDto {
  final String text;

  TextHistoryDto._fromMap(Map<String, dynamic> payload)
      : this.text = payload['text'] ?? 'No text available',
        super._(kind: payload['kind']!);
}

class ImageHistoryDto extends HistoryContentDto {
  final ImageDto? image;

  ImageHistoryDto._fromMap(Map<String, dynamic> payload)
      : this.image = payload['url'] == null ? null : ImageDto.fromMap(payload),
        super._(kind: payload['kind']!);
}

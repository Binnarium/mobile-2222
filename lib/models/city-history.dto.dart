import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/models/asset.dto.dart';

class CityHistoryDto {
  CityHistoryDto.fromMap(Map<String, dynamic> payload)
      : content = ((payload['content'] ?? <dynamic>[]) as List)
            .map((dynamic e) =>
                HistoryContentDto.fromJson(e as Map<String, dynamic>))
            .toList();

  final List<HistoryContentDto> content;
}

abstract class HistoryContentDto {
  HistoryContentDto._({
    required this.kind,
  });

  final String kind;

  static HistoryContentDto fromJson(Map<String, dynamic> payload) {
    final String kind = payload['kind'] as String;

    if (kind == 'HISTORY#TITLE') {
      return TitleHistoryDto._fromMap(payload);
    }

    if (kind == 'HISTORY#TEXT') {
      return TextHistoryDto._fromMap(payload);
    }

    if (kind == 'HISTORY#IMAGE') {
      return ImageHistoryDto._fromMap(payload);
    }

    // ignore: only_throw_errors
    throw ErrorDescription('Invalid history content');
  }
}

class TitleHistoryDto extends HistoryContentDto {
  TitleHistoryDto._fromMap(Map<String, dynamic> payload)
      : title = payload['title'] as String? ?? 'No title available',
        super._(kind: payload['kind']! as String);

  final String title;
}

class TextHistoryDto extends HistoryContentDto {
  TextHistoryDto._fromMap(Map<String, dynamic> payload)
      : text = payload['text'] as String? ?? 'No text available',
        super._(kind: payload['kind']! as String);

  final String text;
}

class ImageHistoryDto extends HistoryContentDto {
  ImageHistoryDto._fromMap(Map<String, dynamic> payload)
      : image = payload['url'] == null ? null : ImageDto.fromMap(payload),
        super._(kind: payload['kind']! as String);

  final ImageDto? image;
}

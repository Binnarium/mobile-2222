import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class CityHistoryDto {
  final List<HistoryContentDto> content;

  CityHistoryDto.fromMap(Map<String, dynamic> payload)
      : content = ((payload['content'] ?? <dynamic>[]) as List)
            .map((dynamic e) =>
                HistoryContentDto.fromJson(e as Map<String, dynamic>))
            .toList();
}

abstract class HistoryContentDto {
  HistoryContentDto._({
    required this.kind,
  });
  
  final String kind;


  static HistoryContentDto fromJson(Map<String, dynamic> payload) {
    final String kind = payload['kind'] as String;

    if (kind == 'HISTORY#TITLE') return TitleHistoryDto._fromMap(payload);

    if (kind == 'HISTORY#TEXT') return TextHistoryDto._fromMap(payload);

    if (kind == 'HISTORY#IMAGE') return ImageHistoryDto._fromMap(payload);

    // ignore: only_throw_errors
    throw ErrorDescription('Invalid history content');
  }
}

class TitleHistoryDto extends HistoryContentDto {
  final String title;

  TitleHistoryDto._fromMap(Map<String, dynamic> payload)
      : title = payload['title'] as String? ?? 'No title available',
        super._(kind: payload['kind']! as String);
}

class TextHistoryDto extends HistoryContentDto {
  final String text;

  TextHistoryDto._fromMap(Map<String, dynamic> payload)
      : text = payload['text'] as String? ?? 'No text available',
        super._(kind: payload['kind']! as String);
}

class ImageHistoryDto extends HistoryContentDto {
  final ImageDto? image;

  ImageHistoryDto._fromMap(Map<String, dynamic> payload)
      : image = payload['url'] == null ? null : ImageDto.fromMap(payload),
        super._(kind: payload['kind']! as String);
}

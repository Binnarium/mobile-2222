abstract class HistoryDto {
  final String kind;

  HistoryDto._({
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
  }) : super._(kind: kind);
}

class TextHistoryDto extends HistoryDto {
  final String? text;

  TextHistoryDto({
    required String kind,
    this.text,
  }) : super._(kind: kind);
}

class ImageHistoryDto extends HistoryDto {
  final String? url;

  ImageHistoryDto({
    required String kind,
    this.url,
  }) : super._(kind: kind);
}

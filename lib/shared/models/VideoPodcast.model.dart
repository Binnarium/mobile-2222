abstract class ContentDto {
  final String kind;

  ContentDto._({
    required this.kind,
  });

  static ContentDto fromJson(Map<String, dynamic> payload) {
    final String kind = payload['kind'];
    if (kind == 'CONTENT#VIDEO')
      return VideoDto(
        kind: kind,
        title: payload['title'],
        url: payload['url'],
        author: payload['author'],
        description: payload['description'],
      );
    else
      return PodcastDto(
        kind: kind,
        url: payload['url'],
        author: payload['author'],
        title: payload['title'],
        description: payload['description'],
      );
  }
}

class VideoDto extends ContentDto {
  final String? url;
  final String? author;
  final String? description;
  final String? title;

  VideoDto({
    required String kind,
    this.url,
    this.title,
    this.author,
    this.description,
  }) : super._(kind: kind);
}

class PodcastDto extends ContentDto {
  final String? text;
  final String? url;
  final String? author;
  final String? description;
  final String? title;

  PodcastDto({
    required String kind,
    this.url,
    this.author,
    this.description,
    this.title,
    this.text,
  }) : super._(kind: kind);
}

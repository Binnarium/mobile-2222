import 'package:lab_movil_2222/models/asset.dto.dart';

abstract class ContentDto<T> {
  final String kind;
  final String description;
  final String author;
  final String title;
  final T content;

  ContentDto._({
    required this.kind,
    required this.author,
    required this.description,
    required this.content,
    required this.title,
  });

  static ContentDto fromJson(Map<String, dynamic> payload) {
    final String kind = payload['kind'];
    if (kind == 'CONTENT#VIDEO')
      return VideoContentDto(
        kind: kind,
        title: payload['title'],
        author: payload['author'],
        description: payload['description'],
        video: VideoDto.fromMap(payload),
      );
    else
      return PodcastContentDto(
        kind: kind,
        podcast: AudioDto.fromMap(payload),
        author: payload['author'],
        title: payload['title'],
        description: payload['description'],
      );
  }
}

class VideoContentDto extends ContentDto<VideoDto> {
  VideoContentDto({
    required String kind,
    required String author,
    required String description,
    required String title,
    required VideoDto video,
  }) : super._(
          kind: kind,
          author: author,
          description: description,
          title: title,
          content: video,
        );
}

class PodcastContentDto extends ContentDto<AudioDto> {
  PodcastContentDto({
    required String kind,
    required String author,
    required String description,
    required String title,
    required AudioDto podcast,
  }) : super._(
          kind: kind,
          author: author,
          description: description,
          title: title,
          content: podcast,
        );
}

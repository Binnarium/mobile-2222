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
    final String kind = payload['kind'] as String;
    if (kind == 'CONTENT#VIDEO') {
      return VideoContentDto(
        kind: kind,
        title: payload['title'] as String? ?? 'Title not available',
        author: payload['author'] as String? ?? 'Author not available',
        description:
            payload['description'] as String? ?? 'Description not available',
        video: VideoDto.fromMap(payload),
      );
    } else {
      return PodcastContentDto(
        kind: kind,
        podcast: AudioDto.fromMap(payload),
        author: payload['author'] as String? ?? 'Falta autor',
        title: payload['title'] as String? ?? 'Falta agregar titulo',
        description:
            payload['description'] as String? ?? 'Falta agregar descripción',
      );
    }
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

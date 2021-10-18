import 'package:lab_movil_2222/assets/models/asset.dto.dart';
import 'package:lab_movil_2222/assets/video/models/video.model.dart';

abstract class ContentDto<T> {
  /// constructor
  ContentDto._({
    required this.kind,
    required this.author,
    required this.description,
    required this.content,
    required this.title,
  });

  final String kind;
  final String description;
  final String author;
  final String title;
  final T content;

  static ContentDto fromJson(Map<String, dynamic> payload) {
    final String kind = payload['kind'] as String;
    if (kind == 'CONTENT#VIDEO') {
      return VideoContentDto(
        kind: kind,
        title: payload['title'] as String? ?? 'Title not available',
        author: payload['author'] as String? ?? 'Author not available',
        description:
            payload['description'] as String? ?? 'Description not available',
        video: VideoModel.fromMap(payload),
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

class VideoContentDto extends ContentDto<VideoModel> {
  VideoContentDto({
    required String kind,
    required String author,
    required String description,
    required String title,
    required VideoModel video,
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

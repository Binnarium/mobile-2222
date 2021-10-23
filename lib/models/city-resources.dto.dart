import 'package:flutter/rendering.dart';
import 'package:lab_movil_2222/assets/models/asset.dto.dart';

class CityResourcesDto {
  /// constructor
  CityResourcesDto.fromMap(Map<String, dynamic> payload)
      : externalLinks = ((payload['externalLinks'] ?? <dynamic>[]) as List)
            .map((dynamic e) =>
                ExternalLinkDto.fromMap(e as Map<String, dynamic>))
            .toList(),
        readings = ((payload['readings'] ?? <dynamic>[]) as List)
            .map((dynamic e) => ReadingDto.fromMap(e as Map<String, dynamic>))
            .toList();

  /// params
  final List<ExternalLinkDto> externalLinks;

  final List<ReadingDto> readings;
}

class ReadingDto {
  /// constructor
  ReadingDto.fromMap(Map<String, dynamic> payload)
      : name = payload['name'] as String? ?? 'Sin nombre',
        about = payload['about'] as String? ?? 'Sin descripción',
        author = payload['author'] as String? ?? 'Sin autor',
        link = payload['link'] as String?,
        publishedYear = payload['publishedYear'] as int?,
        cover = (payload['cover']['url'] == null)
            ? null
            : ImageDto.fromMap(payload['cover'] as Map<String, dynamic>);

  final ImageDto? cover;
  final String about;
  final String author;
  final String name;
  final String? link;
  final int? publishedYear;

  String get validLink => link ?? 'https://www.google.com/search?q=$name';

  String get tagline =>
      [author, if (publishedYear != null) publishedYear].join(' | ');

  ImageProvider get placeholder =>
      const AssetImage('assets/images/book-placeholder.png');
}

abstract class ExternalLinkDto {
  /// constructor
  ExternalLinkDto._fromMap(Map<String, dynamic> data)
      : kind = data['kind'] as String,
        link = data['link'] as String? ?? 'https://google.com',
        title = data['title'] as String? ?? '',
        description =
            data['description'] as String? ?? 'no description available';

  static ExternalLinkDto fromMap(Map<String, dynamic> data) {
    final String kind = data['kind'] as String;

    if (kind == 'LINK#YOUTUBE') {
      return _YoutubeLinkDto._fromMap(data);
    }
    if (kind == 'LINK#FACEBOOK') {
      return _FacebookLinkDto._fromMap(data);
    }
    if (kind == 'LINK#TWITTER') {
      return _TwitterLinkDto._fromMap(data);
    }
    if (kind == 'LINK#INSTAGRAM') {
      return _InstagramLinkDto._fromMap(data);
    }
    if (kind == 'LINK#TIK_TOK') {
      return _TikTokLinkDto._fromMap(data);
    }
    return _OtherLinkDto._fromMap(data);
  }

  final String kind;
  final String link;
  final String title;
  final String description;

  /// display an image if avalilable, otherise on
  ImageProvider get iconImage;
}

class _YoutubeLinkDto extends ExternalLinkDto {
  _YoutubeLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage =>
      const AssetImage('assets/images/youtube.png');
}

class _FacebookLinkDto extends ExternalLinkDto {
  _FacebookLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage =>
      const AssetImage('assets/images/facebook.png');
}

class _TwitterLinkDto extends ExternalLinkDto {
  _TwitterLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage =>
      const AssetImage('assets/images/twitter.png');
}

class _OtherLinkDto extends ExternalLinkDto {
  _OtherLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage =>
      const AssetImage('assets/images/link.png');
}

class _InstagramLinkDto extends ExternalLinkDto {
  _InstagramLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage =>
      const AssetImage('assets/images/instagram.png');
}

class _TikTokLinkDto extends ExternalLinkDto {
  _TikTokLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage =>
      const AssetImage('assets/images/tiktok.png');
}

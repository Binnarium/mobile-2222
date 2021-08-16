import 'package:flutter/rendering.dart';
import 'package:lab_movil_2222/models/asset.dto.dart';

class CityResourcesDto {
  final List<ExternalLinkDto> externalLinks;
  final List<ReadingDto> readings;

  CityResourcesDto.fromMap(Map<String, dynamic> payload)
      : this.externalLinks = ((payload['externalLinks'] ?? []) as List)
            .map((e) => ExternalLinkDto.fromMap(e))
            .toList(),
        this.readings = ((payload['readings'] ?? []) as List)
            .map((e) => ReadingDto.fromMap(e))
            .toList();
}

class ReadingDto {
  final ImageDto? cover;
  final String about;
  final String author;
  final String name;
  final String? link;
  final int? publishedYear;

  ReadingDto.fromMap(Map<String, dynamic> payload)
      : this.name = payload['name'],
        this.about = payload['about'],
        this.author = payload['author'] ?? 'Sin autor',
        this.link = payload['link'] ?? null,
        this.publishedYear = payload['publishedYear'] ?? null,
        this.cover = (payload['cover']['url'] == null)
            ? null
            : ImageDto.fromMap(payload['cover']);

  String get validLink =>
      this.link ?? 'https://www.google.com/search?q=${this.name}';

  String get tagline => [
        this.author,
        if (this.publishedYear != null) this.publishedYear
      ].join(' | ');

  ImageProvider get placeholder =>
      AssetImage('assets/images/book-placeholder.png');
}

abstract class ExternalLinkDto {
  final String kind;
  final String link;
  final String title;
  final String description;

  ExternalLinkDto._fromMap(Map<String, dynamic> data)
      : this.kind = data['kind'],
        this.link = data['link'] ?? 'https://google.com',
        this.title = data['title'],
        this.description = data['description'];

  static ExternalLinkDto fromMap(Map<String, dynamic> data) {
    final String kind = data['kind'];

    if (kind == 'LINK#YOUTUBE') return _YoutubeLinkDto._fromMap(data);
    if (kind == 'LINK#FACEBOOK') return _FacebookLinkDto._fromMap(data);
    if (kind == 'LINK#TWITTER') return _TwitterLinkDto._fromMap(data);
    if (kind == 'LINK#INSTAGRAM') return _InstagramLinkDto._fromMap(data);
    if (kind == 'LINK#TIK_TOK') return _TikTokLinkDto._fromMap(data);
    return _OtherLinkDto._fromMap(data);
  }

  /// display an image if avalilable, otherise on
  ImageProvider get iconImage;
}

class _YoutubeLinkDto extends ExternalLinkDto {
  _YoutubeLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage =>
      AssetImage('assets/images/youtube.png');
}

class _FacebookLinkDto extends ExternalLinkDto {
  _FacebookLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage =>
      AssetImage('assets/images/facebook.png');
}

class _TwitterLinkDto extends ExternalLinkDto {
  _TwitterLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage =>
      AssetImage('assets/images/twitter.png');
}

class _OtherLinkDto extends ExternalLinkDto {
  _OtherLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage => AssetImage('assets/images/link.png');
}

class _InstagramLinkDto extends ExternalLinkDto {
  _InstagramLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage =>
      AssetImage('assets/images/instagram.png');
}

class _TikTokLinkDto extends ExternalLinkDto {
  _TikTokLinkDto._fromMap(Map<String, dynamic> payload)
      : super._fromMap(payload);

  @override
  ImageProvider<Object> get iconImage => AssetImage('assets/images/tiktok.png');
}

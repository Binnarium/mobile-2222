import 'package:flutter/material.dart';

/// Base class for statics assets shared in the app
///
/// use the specific kind of asset like:
/// - [ImageDto] for image kind of assets
/// - [VideoDto] for video kind of assets
/// - [AudioDto] for audio kind of assets
abstract class AssetDto {
  final String url;
  final String path;
  final String name;

  AssetDto({
    required this.url,
    required this.path,
    required this.name,
  });

  Map<String, dynamic> toMap() {
    return {
      'url': this.url,
      'path': this.path,
      'name': this.name,
    };
  }
}

/// Video asset
class VideoDto extends AssetDto {
  final int duration;
  final String format;

  /// defaault constructor
  VideoDto({
    required this.duration,
    required this.format,
    required String name,
    required String path,
    required String url,
  }) : super(
          name: name,
          path: path,
          url: url,
        );

  VideoDto.fromMap(final Map<String, dynamic> payload)
      : this.format = payload['format'] ?? '',
        this.duration = payload['duration'] ?? '',
        super(
          name: payload['name'] ?? '',
          path: payload['path'] ?? '',
          url: payload['url'] ?? '',
        );

  ImageProvider get placeholderImage =>
      AssetImage('assets/images/video-placeholder.png');

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();

    map.addAll({
      "duration": this.duration,
      "format": this.format,
    });

    return map;
  }
}

/// Image asset
class ImageDto extends AssetDto {
  final int width;
  final int height;

  ImageDto({
    required this.height,
    required this.width,
    required String name,
    required String path,
    required String url,
  }) : super(
          name: name,
          path: path,
          url: url,
        );

  ImageDto.fromMap(final Map<String, dynamic> payload)
      : this.height = payload['height'] ?? 0,
        this.width = payload['width'] ?? 0,
        super(
          name: payload['name'] ?? "",
          path: payload['path'] ?? "",
          url: payload['url'] ?? "",
        );

  ImageProvider get image => NetworkImage(this.url);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();

    map.addAll({
      "width": this.width,
      "height": this.height,
    });

    return map;
  }
}

/// Audio asset
class AudioDto extends AssetDto {
  AudioDto.fromMap(final Map<String, dynamic> payload)
      : super(
          name: payload['name'],
          path: payload['path'],
          url: payload['url'],
        );
}

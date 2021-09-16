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
    return <String, dynamic>{
      'url': url,
      'path': path,
      'name': name,
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
      : format = payload['format'] as String? ?? '',
        duration = payload['duration'] as int? ?? 0,
        super(
          name: payload['name'] as String? ?? '',
          path: payload['path'] as String? ?? '',
          url: payload['url'] as String? ?? '',
        );

  ImageProvider get placeholderImage =>
      AssetImage('assets/images/video-placeholder.png');

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();

    map.addAll(<String, dynamic>{
      'duration': duration,
      'format': format,
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
      : height = payload['height'] as int? ?? 0,
        width = payload['width'] as int? ?? 0,
        super(
          name: payload['name'] as String? ?? '',
          path: payload['path'] as String? ?? '',
          url: payload['url'] as String? ?? '',
        );

  ImageProvider get image => NetworkImage(url);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = super.toMap();

    map.addAll(<String, dynamic>{
      'width': width,
      'height': height,
    });

    return map;
  }
}

/// Audio asset
class AudioDto extends AssetDto {
  AudioDto.fromMap(final Map<String, dynamic> payload)
      : super(
          name: payload['name'] as String,
          path: payload['path'] as String,
          url: payload['url'] as String,
        );
}

/// Project File asset
class ProjectFileDto extends AssetDto {
  ProjectFileDto({
    required String name,
    required String path,
    required String url,
  }) : super(
          name: name,
          path: path,
          url: url,
        );

  ProjectFileDto.fromMap(final Map<String, dynamic> payload)
      : super(
          name: payload['name'] as String? ?? '',
          path: payload['path'] as String? ?? '',
          url: payload['url'] as String? ?? '',
        );
}

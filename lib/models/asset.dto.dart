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
}

/// Video asset
class VideoDto extends AssetDto {
  final int duration;
  final String format;

  VideoDto.fromMap(final Map<String, dynamic> payload)
      : this.format = payload['format'] ?? '',
        this.duration = payload['duration'] ?? '',
        super(
          name: payload['name'] ?? '',
          path: payload['path'] ?? '',
          url: payload['url'] ?? '',
        );
}

/// Image asset
class ImageDto extends AssetDto {
  final int width;
  final int height;

  ImageDto.fromMap(final Map<String, dynamic> payload)
      : this.height = payload['height'],
        this.width = payload['width'],
        super(
          name: payload['name'],
          path: payload['path'],
          url: payload['url'],
        );

  ImageProvider get image => NetworkImage(this.url);
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

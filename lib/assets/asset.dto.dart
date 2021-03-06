import 'package:flutter/material.dart';

/// Base class for statics assets shared in the app
///
/// use the specific kind of asset like:
/// - [ImageDto] for image kind of assets
/// - [VideoModel] for video kind of assets
/// - [AudioDto] for audio kind of assets
abstract class AssetDto {
  AssetDto({
    required this.url,
    required this.path,
    required this.name,
  });

  final String url;
  final String path;
  final String name;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'url': url,
      'path': path,
      'name': name,
    };
  }
}

/// Image asset
class ImageDto extends AssetDto {
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

  final int width;
  final int height;

  ImageProvider get image => NetworkImage(url);

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = super.toMap();

    map.addAll(<String, dynamic>{
      'width': width,
      'height': height,
    });

    return map;
  }
}

/// Audio asset
class AudioDto extends AssetDto {
  AudioDto({
    required String name,
    required String path,
    required String url,
  }) : super(
          name: name,
          path: path,
          url: url,
        );

  AudioDto.fromMap(final Map<String, dynamic> payload)
      : super(
          name: payload['name'] as String,
          path: payload['path'] as String,
          url: payload['url'] as String,
        );
}

/// Project File asset
class PdfDto extends AssetDto {
  PdfDto({
    required String name,
    required String path,
    required String url,
  }) : super(
          name: name,
          path: path,
          url: url,
        );

  PdfDto.fromMap(final Map<String, dynamic> payload)
      : super(
          name: payload['name'] as String? ?? '',
          path: payload['path'] as String? ?? '',
          url: payload['url'] as String? ?? '',
        );
}

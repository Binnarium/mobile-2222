import 'package:lab_movil_2222/assets/models/asset.dto.dart';

/// Video asset
class VideoModel extends AssetDto {
  VideoModel({
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

  VideoModel.fromMap(final Map<String, dynamic> payload)
      : format = payload['format'] as String? ?? '',
        duration = payload['duration'] as int? ?? 0,
        super(
          name: payload['name'] as String? ?? '',
          path: payload['path'] as String? ?? '',
          url: payload['url'] as String? ?? '',
        );

  final int duration;
  final String format;

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> map = super.toMap();

    map.addAll(<String, dynamic>{
      'duration': duration,
      'format': format,
    });

    return map;
  }
}

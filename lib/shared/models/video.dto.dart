import 'asset.dto.dart';

class VideoDto extends AssetDto {
  final int duration;
  final String format;

  VideoDto({
    required String url,
    required String path,
    required String name,
    required this.duration,
    required this.format,
  }) : super(
          name: name,
          path: path,
          url: url,
        );
}

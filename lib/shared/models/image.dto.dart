import 'asset.dto.dart';

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
}

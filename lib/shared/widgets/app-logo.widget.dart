import 'package:flutter/widgets.dart';

/// Available app logo images
enum AppImage {
  cityLogo,
  animatedAppLogo,
  defaultAppLogo,
}

/// Map containing all available app images
const Map<AppImage, ImageProvider> _AppImages = {
  /// Image used inside each city, this image has a transparent 2222 word witch enables
  /// easy merging with the colored background
  AppImage.cityLogo: AssetImage('assets/backgrounds/decorations/logo_leaf.png'),
  /// TODO: add docs
  AppImage.defaultAppLogo: AssetImage('assets/backgrounds/logo_background2.png'),
  /// TODO: add docs
  AppImage.animatedAppLogo: AssetImage('assets/backgrounds/logo_background1.png')
};

/// wrapper to get an app logo
ImageProvider getAppLogo(AppImage kind) {
  assert(AppImage.values.length == _AppImages.entries.length,
      'Not every app logo has been defined');

  /// validate all images are defined in the app images map
  return _AppImages[kind]!;
}

/// widget of an app logo image
class AppLogo extends Image {
  AppLogo({
    Key? key,
    required AppImage kind,
    FilterQuality? filterQuality,
  }) : super(
          key: key,
          filterQuality: filterQuality ?? FilterQuality.high,
          image: getAppLogo(kind),
        );
}

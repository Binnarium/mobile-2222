import 'package:flutter/widgets.dart';

/// Available app logo images
enum AppImage {
  /// Image used inside each city, this image has a transparent 2222 word witch enables
  /// easy merging with the colored background
  cityLogo,

  animatedAppLogo,

  utplLogo,

  defaultAppLogo,

  loadingLogo,
}

/// Map containing all available app images
const Map<AppImage, ImageProvider> _AppImages = {
  AppImage.cityLogo: AssetImage('assets/backgrounds/decorations/logo_leaf.png'),
  AppImage.defaultAppLogo: AssetImage('assets/images/logo-2222.png'),
  AppImage.animatedAppLogo: AssetImage('assets/images/logo-2222.png'),
  AppImage.utplLogo: AssetImage('assets/images/logo-utpl.png'),
  AppImage.loadingLogo: AssetImage('assets/loaders/monster-placeholder.gif'),
};

/// wrapper to get an app logo
ImageProvider getAppLogo(AppImage kind) {
  /// validate all images have been implemented
  assert(
    AppImage.values.length == _AppImages.entries.length,
    'Not every app logo has been defined',
  );

  /// validate all images are defined in the app images map
  return _AppImages[kind]!;
}

/// widget of an app logo image
class AppLogo extends Image {
  AppLogo({
    Key? key,
    required AppImage kind,
    FilterQuality? filterQuality,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
  }) : super(
          key: key,
          filterQuality: filterQuality ?? FilterQuality.high,
          image: getAppLogo(kind),
          width: width,
          height: height,
          fit: fit,
          color: color,
        );
}

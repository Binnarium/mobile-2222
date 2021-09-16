import 'package:flutter/material.dart';

/// available background decorations
enum BackgroundDecorationStyle {
  topRight,
  topLeft,
  bottomRight,
  bottomLeft,
  path,
}

/// locations of assets
const Map<BackgroundDecorationStyle, ImageProvider> _backgroundsDecorations = {
  BackgroundDecorationStyle.path:
      AssetImage('assets/backgrounds/background-decorations/path.png'),
  BackgroundDecorationStyle.topLeft:
      AssetImage('assets/backgrounds/background-decorations/top-left.png'),
  BackgroundDecorationStyle.topRight:
      AssetImage('assets/backgrounds/background-decorations/top-right.png'),
  BackgroundDecorationStyle.bottomLeft:
      AssetImage('assets/backgrounds/background-decorations/bottom-left.png'),
  BackgroundDecorationStyle.bottomRight:
      AssetImage('assets/backgrounds/background-decorations/bottom-right.png'),
};

class BackgroundDecoration extends StatelessWidget {
  const BackgroundDecoration({
    Key? key,
    this.backgroundDecorationsStyles = const [],
    required this.child,
  }) : super(key: key);

  final List<BackgroundDecorationStyle> backgroundDecorationsStyles;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          /// decoration top right
          if (backgroundDecorationsStyles
              .contains(BackgroundDecorationStyle.topRight))
            Positioned.fill(
              child: Image(
                image: _backgroundsDecorations[
                    BackgroundDecorationStyle.topRight]!,
                width: double.infinity,
                alignment: Alignment.topRight,
                fit: BoxFit.contain,
              ),
            ),

          /// decoration top left
          if (backgroundDecorationsStyles
              .contains(BackgroundDecorationStyle.topLeft))
            Positioned.fill(
              child: Image(
                image:
                    _backgroundsDecorations[BackgroundDecorationStyle.topLeft]!,
                width: double.infinity,
                alignment: Alignment.topLeft,
                fit: BoxFit.contain,
              ),
            ),

          /// decoration bottom left
          if (backgroundDecorationsStyles
              .contains(BackgroundDecorationStyle.bottomLeft))
            Positioned.fill(
              child: Image(
                alignment: Alignment.bottomLeft,
                image: _backgroundsDecorations[
                    BackgroundDecorationStyle.bottomLeft]!,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),

          /// decoration bottom right
          if (backgroundDecorationsStyles
              .contains(BackgroundDecorationStyle.bottomRight))
            Positioned.fill(
              child: Image(
                alignment: Alignment.bottomRight,
                image: _backgroundsDecorations[
                    BackgroundDecorationStyle.bottomRight]!,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),

          /// background path decoration
          if (backgroundDecorationsStyles
              .contains(BackgroundDecorationStyle.path))
            Positioned.fill(
              child: Image(
                image: _backgroundsDecorations[BackgroundDecorationStyle.path]!,
                width: double.infinity,
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
              ),
            ),

          /// main content
          Positioned.fill(child: child),
        ],
      ),
    );
  }
}

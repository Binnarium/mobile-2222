import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';

/// available background decorations
enum BackgroundDecorationStyle {
  topRight,
  topLeft,
  bottomRight,
  bottomLeft,
  path,
}

/// locations of assets
const Map<BackgroundDecorationStyle, ImageProvider> _BackgroundsDecorations = {
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
          if (this
              .backgroundDecorationsStyles
              .contains(BackgroundDecorationStyle.topRight))
            Positioned.fill(
              child: Image(
                image: _BackgroundsDecorations[
                    BackgroundDecorationStyle.topRight]!,
                width: double.infinity,
                alignment: Alignment.topRight,
                fit: BoxFit.contain,
              ),
            ),

          /// decoration top left
          if (this
              .backgroundDecorationsStyles
              .contains(BackgroundDecorationStyle.topLeft))
            Positioned.fill(
              child: Image(
                image:
                    _BackgroundsDecorations[BackgroundDecorationStyle.topLeft]!,
                width: double.infinity,
                alignment: Alignment.topLeft,
                fit: BoxFit.contain,
              ),
            ),

          /// decoration bottom left
          if (this
              .backgroundDecorationsStyles
              .contains(BackgroundDecorationStyle.bottomLeft))
            Positioned.fill(
              child: Image(
                alignment: Alignment.bottomLeft,
                image: _BackgroundsDecorations[
                    BackgroundDecorationStyle.bottomLeft]!,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),

          /// decoration bottom right
          if (this
              .backgroundDecorationsStyles
              .contains(BackgroundDecorationStyle.bottomRight))
            Positioned.fill(
              child: Image(
                alignment: Alignment.bottomRight,
                image: _BackgroundsDecorations[
                    BackgroundDecorationStyle.bottomRight]!,
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),

          /// background path decoration
          if (this
              .backgroundDecorationsStyles
              .contains(BackgroundDecorationStyle.path))
            Positioned.fill(
              child: Image(
                image: _BackgroundsDecorations[BackgroundDecorationStyle.path]!,
                width: double.infinity,
                fit: BoxFit.contain,
                alignment: Alignment.bottomCenter,
                color: Colors2222.white.withOpacity(0.2),
              ),
            ),

          /// main content
          Positioned.fill(child: this.child),
        ],
      ),
    );
  }
}

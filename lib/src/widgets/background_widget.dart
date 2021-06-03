import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget {
  final Color backgroundColor;
  final Image? backgroundImage;

  BackgroundWidget({required this.backgroundColor, this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    bool _hasImage = true;
    if (backgroundImage == null) {
      _hasImage = false;
    }

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: backgroundColor,
      child: _hasImage ? _backgroundImagePainting() : Container(),
    );
  }

  _backgroundImagePainting() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: backgroundImage,
    );
  }
}

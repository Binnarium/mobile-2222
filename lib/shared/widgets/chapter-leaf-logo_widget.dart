import 'package:flutter/material.dart';

class ChapterLeafLogoWidget extends StatelessWidget {
  const ChapterLeafLogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      alignment: Alignment.topLeft,
      image: AssetImage(
        'assets/backgrounds/decorations/logo_leaf.png',
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// add a background to the app, supported backgrounds incudes a color and a image
class CustomBackground extends StatelessWidget {
  const CustomBackground({
    Key? key,
    required this.backgroundColor,
    this.backgroundImages,
  }) : super(key: key);

  final Color backgroundColor;

  final List<Image>? backgroundImages;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: Stack(
        children: [
          /// add the color of the box
          Container(
            width: double.infinity,
            height: double.infinity,
            color: this.backgroundColor,
          ),

          /// add stack of images to the widget over the colored container
          ...?this.backgroundImages,
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

@Deprecated('Since Scaffold2222 this widget should not be used')
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
          ...?this.backgroundImages?.map(
                (widget) => SizedBox.expand(
                  child: widget,
                ),
              ),
        ],
      ),
    );
  }
}

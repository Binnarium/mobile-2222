import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

enum _BubbleKind {
  small,
  big,
}

/// determines the padding for normal bubbles
const Map<_BubbleKind, AssetImage> _BubbleImages = {
  _BubbleKind.small: AssetImage('assets/backgrounds/decorations/blob-1.png'),
  _BubbleKind.big: AssetImage(
      'assets/backgrounds/decorations/bubble_background_decoration_type2.png'),
};

/// determines the padding for normal bubbles
const Map<_BubbleKind, EdgeInsetsGeometry> _BubblePaddings = {
  _BubbleKind.small: EdgeInsets.fromLTRB(40, 40, 38, 37),
  _BubbleKind.big: EdgeInsets.fromLTRB(48, 45, 45, 42),
};

class IdeaBubbleWidget extends StatelessWidget {
  IdeaBubbleWidget({
    Key? key,
    required String text,
  })  : text = text.trim(),
        super(key: key);

  /// texto que irá dentro del contenedor
  final String text;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final _BubbleKind kind =
        text.length <= 60 ? _BubbleKind.small : _BubbleKind.big;

    /// spacing between bubble and border
    final EdgeInsetsGeometry innerPadding = _BubblePaddings[kind]!;

    /// bubble image
    final ImageProvider image = _BubbleImages[kind]!;
    final double containerWidth = kind == _BubbleKind.small
        ? min(size.width * 0.5, 200)
        : min(size.width * 0.7, 300);

    /// contenedor principal que contendrá la imagen y el texto en un stack
    return SizedBox(
      width: containerWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Image(
              fit: BoxFit.fill,
              image: image,
            ),
          ),
          Container(
            padding: innerPadding,
            child: Center(
              child: Markdown2222(
                data: text,
                textColor: Colors2222.black,
                contentAlignment: WrapAlignment.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

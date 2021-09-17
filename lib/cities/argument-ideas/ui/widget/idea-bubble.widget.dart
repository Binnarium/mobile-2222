import 'package:flutter/material.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

enum BubbleKind {
  type1,
  type2,
  type3,
}

/// determines the padding for normal bubbles
const Map<BubbleKind, AssetImage> _BubbleImages = {
  BubbleKind.type1: AssetImage('assets/backgrounds/decorations/blob-1.png'),
  BubbleKind.type2: AssetImage('assets/backgrounds/decorations/blob-2.png'),
  BubbleKind.type3: AssetImage('assets/backgrounds/decorations/blob-3.png'),
};

/// determines the padding for normal bubbles
const Map<BubbleKind, EdgeInsetsGeometry> _BubblePaddings = {
  BubbleKind.type1: EdgeInsets.fromLTRB(42, 45, 46, 42),
  BubbleKind.type2: EdgeInsets.fromLTRB(52, 50, 45, 42),
  BubbleKind.type3: EdgeInsets.fromLTRB(40, 50, 35, 30),
};

class IdeaBubbleWidget extends StatelessWidget {
  IdeaBubbleWidget({
    Key? key,
    required String text,
    required BubbleKind bubbleKind,
  })  : text = text.trim(),
        image = _BubbleImages[bubbleKind]!,
        innerPadding = _BubblePaddings[bubbleKind]!,
        super(key: key);

  /// texto que irá dentro del contenedor
  final String text;

  /// spacing between bubble and border
  final EdgeInsetsGeometry innerPadding;

  /// bubble image
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    /// contenedor principal que contendrá la imagen y el texto en un stack
    return Stack(
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
              color: Colors.black,
              contentAlignment: WrapAlignment.center,
            ),
          ),
        ),
      ],
    );
  }
}

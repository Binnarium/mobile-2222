import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';

enum BubbleKind {
  TopRight,
  CenterLeft,
  BottomRight,
  TopLeft,
  BottomLeft,
}

Map<BubbleKind, Matrix4> _bubbleRotations = {
  BubbleKind.TopRight: Matrix4.identity() //matriz de perspectiva
    ..setEntry(3, 2, 0.001) //con esto se rota por el eje x
    ..rotateX(math.pi) //se rota eje y
    ..rotateY(math.pi),
  BubbleKind.CenterLeft: Matrix4.identity() //matriz de perspectiva
    ..setEntry(3, 2, 0.001) //con esto se rota por el eje x
    ..rotateX(math.pi) //se rota eje y
    ..rotateY(0)
    ..rotateZ(0.3),
  BubbleKind.BottomLeft: Matrix4.rotationX(0),
  BubbleKind.BottomRight: Matrix4.identity() //matriz de perspectiva
    ..setEntry(3, 2, 0.001) //con esto se rota por el eje x
    ..rotateX(0) //se rota eje y
    ..rotateY(math.pi),
  BubbleKind.TopLeft: Matrix4.identity() //matriz de perspectiva
    ..setEntry(3, 2, 0.001) //con esto se rota por el eje x
    ..rotateX(math.pi) //se rota eje y
    ..rotateY(0),
};

/// determines the padding for normal bubbles
const Map<BubbleKind, EdgeInsetsGeometry> _BubblePaddings = {
  BubbleKind.TopRight: EdgeInsets.fromLTRB(40, 35, 45, 40),
  BubbleKind.CenterLeft: EdgeInsets.fromLTRB(60, 35, 45, 50),
  BubbleKind.BottomLeft: EdgeInsets.fromLTRB(50, 45, 25, 40),
  BubbleKind.BottomRight: EdgeInsets.fromLTRB(40, 45, 45, 40),
  BubbleKind.TopLeft: EdgeInsets.fromLTRB(50, 35, 35, 30),
};

/// determines the padding for big bubbles
const Map<BubbleKind, EdgeInsetsGeometry> _BigBubblePaddings = {
  BubbleKind.TopRight: EdgeInsets.fromLTRB(50, 45, 65, 50),
  BubbleKind.CenterLeft: EdgeInsets.fromLTRB(40, 45, 35, 30),
  BubbleKind.BottomLeft: EdgeInsets.fromLTRB(70, 65, 45, 40),
  BubbleKind.BottomRight: EdgeInsets.fromLTRB(40, 45, 45, 40),
  BubbleKind.TopLeft: EdgeInsets.fromLTRB(30, 35, 55, 30),
};

class IdeaContainerWidget extends StatelessWidget {
  /// texto que irá dentro del contenedor
  final String text;

  /// apply big bubble styles when enabled
  final bool bigStyle;

  IdeaContainerWidget({
    required String text,
    required BubbleKind bubbleKind,
    this.bigStyle = false,
  })  : this.text = text.trim(),
        this.bubbleRotation = _bubbleRotations[bubbleKind]!,
        this.innerPadding = (bigStyle)
            ? _BigBubblePaddings[bubbleKind]!
            : _BubblePaddings[bubbleKind]!;

  final EdgeInsetsGeometry innerPadding;
  final Matrix4 bubbleRotation;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final TextTheme textTheme = Theme.of(context).textTheme;

    /// contenedor principal que contendrá la imagen y el texto en un stack
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          /// uncomment this to make image rotations
          child: Transform(
            //se emplea las rotaciones de arriba
            transform: this.bubbleRotation,
            //para que rote en el mismo eje
            alignment: FractionalOffset.center,
            child: Image(
              fit: BoxFit.fill,
              image: AssetImage(
                'assets/backgrounds/decorations/bubble_background_decoration.png',
              ),
            ),
          ),
        ),
        Padding(
          // padding: this.bigStyle
          //     ? EdgeInsets.fromLTRB(70, 65, 45, 40)
          //     : EdgeInsets.fromLTRB(50, 50, 35, 25),
          padding: this.innerPadding,
          child: Container(
            constraints: BoxConstraints(minHeight: this.bigStyle ? 180 : 100),
            child: Center(
              child: (!this.bigStyle)

                  /// Added markdown to small bubbles since text size isn't
                  /// supported yet
                  ? Markdown2222(
                      data: text,
                      color: Colors.black,
                      contentAlignment: WrapAlignment.center,
                    )
                  : Text(
                      text,
                      textAlign: TextAlign.center,
                      style: textTheme.headline5?.copyWith(color: Colors.black),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}

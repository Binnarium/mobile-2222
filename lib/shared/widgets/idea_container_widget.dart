import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class IdeaContainerWidget extends StatelessWidget {
  /// texto que irá dentro del contenedor
  final String text;

  /// para determinar dónde se encuentra el lado más extenso de la imagen del contenedor
  final int orientation;

  /// apply big bubble styles when enabled
  final bool bigStyle;

  IdeaContainerWidget({
    required String text,
    required this.orientation,
    this.bigStyle = false,
  }) : this.text = text.trim();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// contenedor principal que contendrá la imagen y el texto en un stack
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned.fill(
          /// uncomment this to make image rotations
          // child: _ideasImage(orientation),
          child: Image(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/backgrounds/decorations/bubble_background_decoration.png',
            ),
          ),
        ),
        Padding(
          padding: this.bigStyle
              ? EdgeInsets.fromLTRB(70, 65, 45, 40)
              : EdgeInsets.fromLTRB(50, 50, 35, 25),
          child: Container(
            constraints: BoxConstraints(minHeight: this.bigStyle ? 180 : 100),
            child: Center(
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: (this.bigStyle
                        ? korolevFont.headline5
                        : korolevFont.bodyText1)
                    ?.copyWith(color: Colors.black),
              ),
            ),
          ),
        ),

        // _ideasImage(this.orientation),
        // _textIdea(size, text),
      ],
    );
  }

  //donde se crea la imagen blanca
  _ideasImage(int index) {
    Map<int, String> orientations = {
      0: "TopRight",
      1: "CenterLeft",
      2: "BottomRight",
      3: "TopLeft",
      4: "BottomLeft",
    };

    final String orientation = orientations[index]!;

    Map<String, Matrix4> rotations = {
      "BottomLeft": Matrix4.rotationX(0),
      "TopRight": Matrix4.identity() //matriz de perspectiva
        ..setEntry(3, 2, 0.001) //con esto se rota por el eje x
        ..rotateX(math.pi) //se rota eje y
        ..rotateY(math.pi),
      "TopLeft": Matrix4.identity() //matriz de perspectiva
        ..setEntry(3, 2, 0.001) //con esto se rota por el eje x
        ..rotateX(math.pi) //se rota eje y
        ..rotateY(0),
      "BottomRight": Matrix4.identity() //matriz de perspectiva
        ..setEntry(3, 2, 0.001) //con esto se rota por el eje x
        ..rotateX(0) //se rota eje y
        ..rotateY(math.pi),
      "CenterLeft": Matrix4.identity() //matriz de perspectiva
        ..setEntry(3, 2, 0.001) //con esto se rota por el eje x
        ..rotateX(math.pi) //se rota eje y
        ..rotateY(0)
        ..rotateZ(0.3),
    };
    return Transform(
      //se emplea las rotaciones de arriba
      transform: rotations[orientation]!,
      //para que rote en el mismo eje
      alignment: FractionalOffset.center,
      child: Image(
        fit: BoxFit.fill,
        image: AssetImage(
          'assets/backgrounds/decorations/bubble_background_decoration.png',
        ),
      ),
    );
  }
}

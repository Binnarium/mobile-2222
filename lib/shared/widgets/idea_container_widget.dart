import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class IdeaContainerWidget extends StatelessWidget {
  //texto que irá dentro del contenedor
  final String text;
  //para determinar dónde se encuentra el lado más extenso de la imagen del contenedor
  final int orientation;

  const IdeaContainerWidget({
    required this.text,
    required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    /// contenedor principal que contendrá la imagen y el texto en un stack
    return Stack(
      alignment: Alignment.center,
      children: [
        Positioned(
          child: Image(
            fit: BoxFit.fill,
            image: AssetImage(
              'assets/backgrounds/decorations/bubble_background_decoration.png',
            ),
          ),
          bottom: 0,
          left: 0,
          top: 0,
          right: 0,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 40, 35, 30),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
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

  //donde se crea el container que tiene el texto como child
  Widget _textIdea(Size size, String text) {
    Map<String, EdgeInsets> margins = {
      "TopRight": EdgeInsets.only(
        top: (size.height > 800) ? 20 : 10,
        left: (size.height > 800) ? 15 : 10,
        right: (size.height > 800) ? 20 : 20,
        bottom: (size.height > 800) ? 30 : 10,
      ),
      "CenterLeft": (size.height > 800 && size.width >= 375)
          ? EdgeInsets.only(left: 20, right: 10)
          : EdgeInsets.only(left: 15, right: 10),
      "BottomRight": EdgeInsets.only(
        left: (size.height > 820 && size.width >= 375)
            ? 10
            : (size.width >= 370)
                ? 5
                : 10,
        right: (size.height > 820 && size.width >= 375)
            ? 25
            : (size.width >= 370)
                ? 10
                : 20,
        top: (size.height > 820 && size.width >= 375)
            ? 15
            : (size.width >= 370)
                ? 30
                : 15,
      ),
      "TopLeft": EdgeInsets.only(
        left: (size.height > 820) ? 15 : 22,
        right: (size.height > 820) ? 10 : 15,
        bottom: 15,
      ),
      "BottomLeft": EdgeInsets.only(
        left: (size.height > 820 && size.width >= 375) ? 20 : 25,
        right: (size.height > 820 && size.width >= 375) ? 0 : 10,
        top: (size.height > 820) ? 0 : 15,
      ),
    };

    return Text(
      //se emplea el texto recibido por entrada
      text,

      style: korolevFont.bodyText1?.apply(
        color: Colors.black,
        fontSizeFactor: (size.height > 560)
            ? (size.height > 800 && size.width >= 380)
                ? 0.87
                : (size.width >= 360 && size.height >= 560)
                    ? 0.8
                    : 0.7
            : 0.6,
      ),
    );
  }
}

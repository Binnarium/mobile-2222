import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'dart:math' as math;

class IdeaContainerWidget extends StatelessWidget {
  //width del contenedor
  final double? width;
  //height del contenedor
  final double? height;
  //texto que irá dentro del contenedor
  final String text;
  //para determinar dónde se encuentra el lado más extenso de la imagen del contenedor
  final String? orientation;

  const IdeaContainerWidget(
      {this.width, this.height, required this.text, this.orientation});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //contenedor principal que contendrá la imagen y el texto en un stack
    return Container(
      width: width,
      height: height,
      constraints: BoxConstraints(maxWidth: 200),
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      // alignment: Alignment.center,
      child: Stack(
        children: [
          _ideasImage(width, height),
          _textIdea(size, width, height, text),
        ],
      ),
    );
  }

  //donde se crea la imagen blanca
  _ideasImage(double? width, double? height) {
    Map<String, Matrix4> rotations = {
      "BottomLeft": Matrix4.rotationX(0),
      "TopRight": Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)
        //con esto se rota por el eje x
        ..rotateX(math.pi)
        //se rota eje y
        ..rotateY(math.pi),
      "TopLeft": Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)
        //con esto se rota por el eje x
        ..rotateX(math.pi)
        //se rota eje y
        ..rotateY(0),
      "BottomRight": Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)
        //con esto se rota por el eje x
        ..rotateX(0)
        //se rota eje y
        ..rotateY(math.pi),
      "CenterLeft": Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)
        //con esto se rota por el eje x
        ..rotateX(math.pi)
        //se rota eje y
        ..rotateY(0)
        ..rotateZ(0.3),
    };
    return Transform(
      //se emplea las rotaciones de arriba
      transform: rotations[orientation]!,
      //para que rote en el mismo eje
      alignment: FractionalOffset.center,
      child: Container(
        alignment: Alignment.center,
        child: Image(
          height: height,
          width: width,
          fit: BoxFit.fill,
          image: AssetImage(
            'assets/backgrounds/decorations/bubble_background_decoration.png',
          ),
        ),
      ),
    );
  }

  //donde se crea el container que tiene el texto como child
  _textIdea(Size size, double? width, double? height, String text) {
    Map<String, EdgeInsets> margins = {
      "BottomLeft": EdgeInsets.only(
        left: (size.height > 820 && size.width >= 375) ? 20 : 25,
        right: (size.height > 820 && size.width >= 375) ? 0 : 10,
        top: (size.height > 820) ? 0 : 15,
      ),
      "TopRight": EdgeInsets.only(
        top: (size.height > 800) ? 0 : 10,
        left: 10,
        right: 20,
        bottom: 10,
      ),
      "TopLeft": EdgeInsets.only(
        left: (size.height > 820) ? 15 : 22,
        right: (size.height > 820) ? 10 : 15,
        bottom: 15,
      ),
      "CenterLeft": (size.height > 800 && size.width >= 375)
          ? EdgeInsets.only(left: 20, right: 10)
          : EdgeInsets.only(left: 15, right: 10),
      "BottomRight": EdgeInsets.only(
        left: (size.height > 820 && size.width >= 375) ? 20 : 10,
        right: (size.height > 820 && size.width >= 375) ? 0 : 20,
        top: (size.height > 820) ? 0 : 15,
      ),
    };

    return Container(
      decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      //se emplea la configuración por defecto
      margin: margins[orientation],
      alignment: Alignment.center,
      width: width,
      height: height,
      // color: Colors.red,
      child: Text(
        //se emplea el texto recibido por entrada
        text,

        style: korolevFont.bodyText1?.apply(
          color: Colors.black,
          fontSizeFactor: (size.height > 600)
              ? (size.height > 800 || size.width >= 380)
                  ? 0.85
                  : 0.8
              : 0.6,
        ),

        textAlign: TextAlign.center,
      ),
    );
  }
}

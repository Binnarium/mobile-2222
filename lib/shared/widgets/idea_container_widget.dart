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
    //por defecto la imagen tiene rotación con el lado extenso bottomLeft
    Matrix4 rotation = Matrix4.rotationX(0);
    //rotación para poner el lado extenso en topRight
    if (orientation == "TopRight") {
      rotation = Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)
        //con esto se rota por el eje x
        ..rotateX(math.pi)
        //se rota eje y
        ..rotateY(math.pi);
    }
    //rotación para poner el lado extenso TopLeft
    if (orientation == "TopLeft") {
      rotation = Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)
        //con esto se rota por el eje x
        ..rotateX(math.pi)
        //se rota eje y
        ..rotateY(0);
    }
    //rotación para poner el lado extenso BottomRight
    if (orientation == "BottomRight") {
      rotation = Matrix4.identity()
        //matriz de perspectiva
        ..setEntry(3, 2, 0.001)
        //con esto se rota por el eje x
        ..rotateX(0)
        //se rota eje y
        ..rotateY(math.pi);
    }

    return Transform(
      //se emplea las rotaciones de arriba
      transform: rotation,
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
    //configuración por defecto para el bottomLeft
    EdgeInsetsGeometry margin = EdgeInsets.only(left: 10, right: 10);
    //configuración por defecto para el BottomRight
    if (orientation == "BottomLeft") {
      margin = EdgeInsets.only(
        left: (size.height > 820) ? 12 : 10,
        right: 8,
        top: (size.height > 820) ? 0 : 10,
      );
    }
    //configuración por defecto para el topRight
    if (orientation == "TopRight") {
      margin = EdgeInsets.only(
        top: (size.height > 820) ? 0 : 10,
        left: 10,
        right: 15,
        bottom: (size.height > 820) ? 0 : 15,
      );
    }
    //configuración por defecto para el topLeft
    if (orientation == "TopLeft") {
      margin = EdgeInsets.only(
        left: 15,
        right: 10,
        bottom: 15,
      );
    }
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      //se emplea la configuración por defecto
      margin: margin,
      alignment: Alignment.center,
      width: width,
      height: height,
      // color: Colors.red,
      child: Text(
        //se emplea el texto recibido por entrada
        text,

        style: korolevFont.bodyText1?.apply(
          color: Colors.black,
          fontSizeFactor: (size.height > 700)
              ? (size.height > 800)
                  ? 0.8
                  : 0.7
              : 0.6,
        ),

        textAlign: TextAlign.center,
      ),
    );
  }
}

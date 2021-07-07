import 'package:flutter/material.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class IdeaUnlearnContainerWidget extends StatelessWidget {
  //width del contenedor
  final double? width;
  final Color color;
  //height del contenedor
  final double? height;

  //texto que irá dentro del contenedor
  final String text;
  //para determinar dónde se encuentra el lado más extenso de la imagen del contenedor

  const IdeaUnlearnContainerWidget({
    this.width,
    this.height,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //contenedor principal que contendrá la imagen y el texto en un stack
    return Container(
      width: width,
      height: height,
      constraints: BoxConstraints(maxWidth: 170),
      // decoration: BoxDecoration(border: Border.all(color: Colors.red)),
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
            'assets/backgrounds/decorations/white_idea_container.png',
          ),
        ),
      ),
    );
  }

  //donde se crea el container que tiene el texto como child
  _textIdea(Size size, double? width, double? height, String text) {
    //configuración por defecto para el bottomLeft
    EdgeInsetsGeometry margin = (size.height > 700)
        ? EdgeInsets.only(top: 55, left: 25, right: 25)
        : EdgeInsets.only(top: 25, left: 30, right: 30);
    //configuración por defecto para el BottomRight

    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
      //se emplea la configuración por defecto
      margin: margin,
      alignment: Alignment.center,
      width: width,
      height: height,
      // color: Colors.red,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          Text(
            'IDEAS PARA DESAPRENDER',
            style: korolevFont.headline4?.apply(
                color: color, fontSizeFactor: (size.width > 700) ? 0.8 : 0.6),
          ),
          SizedBox(height: 35),
          Text(
            //se emplea el texto recibido por entrada
            text,
            style: korolevFont.bodyText1?.apply(
                color: Colors.black,
                fontSizeFactor: (size.height > 700) ? 0.9 : 0.85),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: (size.height > 700) ? 10 : 80),
          Image(
            image: AssetImage(
              'assets/icons/idea_unlearn_icon.png',
            ),
            color: color,
            height: (size.height > 700) ? height : height! * 0.3,
          )
        ],
      ),
    );
  }
}

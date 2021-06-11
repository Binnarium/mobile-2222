import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'dart:math' as math;

class ChapterBackgroundWidget extends StatelessWidget {
  final Color backgroundColor;
  final String? reliefPosition;
  ChapterBackgroundWidget({required this.backgroundColor, this.reliefPosition});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          CustomBackground(backgroundColor: this.backgroundColor),
          _relieve(),
        ],
      ),
    );
  }

  /// To draw the relief in a background
  _relieve() {
    ///Map that contains every position that the relief can be
    Map<String, Container> reliefPosition = {
      'top-left': Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: Transform(
          //Para girar la imagen del relieve
          transform: Matrix4.identity()
            //matriz de perspectiva
            ..setEntry(3, 2, 0.001)
            //con esto se rota por el eje x
            ..rotateX(math.pi)
            //se rota eje y
            ..rotateY(math.pi),
          //para que mantenga su eje
          alignment: FractionalOffset.center,
          child: Image(
            image: AssetImage(
              'assets/backgrounds/decorations/background_decoration1.png',
            ),
          ),
        ),
      ),
      'top-right': Container(
        width: double.infinity,
        height: double.infinity,
        alignment: Alignment.topCenter,
        child: Transform(
          //Para girar la imagen del relieve
          transform: Matrix4.identity()
            //matriz de perspectiva
            ..setEntry(3, 2, 0.001)
            //con esto se rota por el eje x
            ..rotateX(math.pi)
            //se rota eje y
            ..rotateY(0),
          //para que mantenga su eje
          alignment: FractionalOffset.center,
          child: Image(
            image: AssetImage(
              'assets/backgrounds/decorations/background_decoration1.png',
            ),
          ),
        ),
      ),
      'bottom-right': Container(
        alignment: Alignment.bottomCenter,
        width: double.infinity,
        height: double.infinity,
        child: Image(
          image: AssetImage(
            'assets/backgrounds/decorations/background_decoration1.png',
          ),
        ),
      ),
    };
    if (this.reliefPosition == null) {
      return Container();
    } else {
      return reliefPosition[this.reliefPosition];
    }
  }
}

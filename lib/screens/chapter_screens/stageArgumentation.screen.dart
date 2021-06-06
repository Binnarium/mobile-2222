import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'dart:math' as math;

import 'package:lab_movil_2222/themes/textTheme.dart';

class StageArgumentationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            print('dx: ${details.delta.dx} dy: ${details.delta.dy}');
            if (details.delta.dx > 5) {
              Navigator.pop(context);
            }
            if (details.delta.dx < -5) {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   print('se movió a la derecha');
              //   return StageIntroductionScreen();
              // },),);
            }
          },
          child: Stack(
            children: [
              //widget custom que crea el background con el logo de la izq
              ChapterBackgroundWidget(
                backgroundColor: ColorsApp.backgroundOrange,
                relieve: _relieve(),
              ),
              //decoración adicional del background
              _backgroundDecoration(size),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  _backgroundDecoration(Size size) {
    return Stack(children: [
      _ghostImage(size),
      _ideasImage(size),
      _textIdea1(size),
      _textIdea2(size),
      _textIdea3(size),
    ]);
  }

  _relieve() {
    return Container(
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
    );
  }

  _ghostImage(Size size) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/Phasm_background_decoration.png',
        ),
      ),
    );
  }

  _ideasImage(Size size) {
    return Container(
      padding: EdgeInsets.only(
          top: size.height * 0.18,
          left: size.width * 0.03,
          right: size.width * 0.1),
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/ideas_background_decoration.png',
        ),
      ),
    );
  }

  _textIdea1(Size size) {
    return Positioned(
      //Para dispositivos con resolución menor a (360,640)
      top: size.height * 0.22,
      left: size.width * 0.23,
      child: Container(
        width: size.width * 0.28,
        height: size.height * 0.12,
        child: Text(
          '¿Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequu?',
          style: korolevFont.bodyText2
              ?.apply(color: Colors.black, fontSizeFactor: 0.8),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _textIdea2(Size size) {
    return Positioned(
      //Para dispositivos con resolución menor a (360,640)
      top: size.height * 0.37,
      left: size.width * 0.05,
      child: Container(
        width: size.width * 0.28,
        height: size.height * 0.12,
        child: Text(
          '¿Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequu?',
          style: korolevFont.bodyText2
              ?.apply(color: Colors.black, fontSizeFactor: 0.8),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  _textIdea3(Size size) {
    return Positioned(
      //Para dispositivos con resolución menor a (360,640)
      top: size.height * 0.275,
      left: size.width * 0.61,
      child: Container(
        width: size.width * 0.28,
        height: size.height * 0.12,
        child: Text(
          '¿Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequu?',
          style: korolevFont.bodyText2
              ?.apply(color: Colors.black, fontSizeFactor: 0.8),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

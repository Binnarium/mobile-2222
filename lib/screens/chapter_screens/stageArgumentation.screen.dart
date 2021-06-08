import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/idea_container_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'dart:math' as math;

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
                hasBanner: true,
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
      Positioned(
        top: size.height * 0.13,
        left: size.width * 0.2,
        child: IdeaContainerWidget(
          text:
              '¿Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequu?',
          width: size.width * 0.36,
          height: size.height * 0.26,
          // rotation: Matrix4.identity()
          //   //matriz de perspectiva
          //   ..setEntry(3, 2, 0.001)
          //   //con esto se rota por el eje x
          //   ..rotateX(0)
          //   //se rota eje y
          //   ..rotateY(0),
        ),
      ),
      Positioned(
        top: size.height * 0.3,
        left: size.width * 0.02,
        child: IdeaContainerWidget(
          text:
              '¿Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequu?',
          width: size.width * 0.35,
          height: size.height * 0.25,
          isTopRight: true,
        ),
      ),
      Positioned(
        top: size.height * 0.23,
        left: size.width * 0.6,
        child: IdeaContainerWidget(
          text:
              '¿Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequu?',
          width: size.width * 0.35,
          height: size.height * 0.25,
          isTopLeft: true,
        ),
      ),
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
}

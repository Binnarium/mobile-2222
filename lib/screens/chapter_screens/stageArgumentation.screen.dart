import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/idea_container_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class StageArgumentationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx > 5) {
              Navigator.pop(context);
            }
            if (details.delta.dx < -5) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return StageObjetivesScreen();
                  },
                ),
              );
            }
          },
          child: Stack(
            children: [
              //widget custom que crea el background con el logo de la izq
              ChapterBackgroundWidget(
                backgroundColor: ColorsApp.backgroundOrange,
                reliefPosition: 'top-right',
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
      ChapterHeadWidget(phaseName: 'etapa 4', chapterName: 'aztlán'),
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

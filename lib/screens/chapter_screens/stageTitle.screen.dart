import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/shared/widgets/background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageTitleScreen extends StatelessWidget {
  static const String route = '/stagescreen';

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 5) {
            Navigator.pop(context);
          }
          if (details.delta.dx < -5) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              print('se movió a la derecha');
              return StageIntroductionScreen();
            }));
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            ChapterBackgroundWidget(
                backgroundColor: ColorsApp.backgroundOrange,
                relieve: _backgroundDecoration(),
                hasBanner: true,
            ),  
            
            _routeCurve(),
            
            _introductionBody(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  _introductionBody(Size size) {
    //Creando el Scroll
    double spacedSize = size.height * 0.165;
    double daysLeftSize = size.height * 0.001;
    if (size.height < 550) {
      spacedSize = size.height * 0.19;
      daysLeftSize = size.height * 0.0014;
    }
    if (size.height < 650) {
      spacedSize = size.height * 0.125;
      daysLeftSize = size.height * 0.001;
    }
    return Column(
      children: [
        SizedBox(height: spacedSize),
        //Texto cambiar por funcionalidad de cuenta de días
        Text('ETAPA 4',
            style: korolevFont.headline3?.apply(
                fontSizeFactor: size.height * 0.0006, fontWeightDelta: -1)),
        SizedBox(height: size.height * 0.01),
        //Texto cambiar por funcionalidad de cuenta de días
        Text('AZTLÁN',
            style: korolevFont.headline1
                ?.apply(fontSizeFactor: daysLeftSize, fontWeightDelta: 5)),
        SizedBox(height: size.height * 0.05),
        _logoContainer(size),
        SizedBox(height: size.height * 0.07),
        Text(
          'Guiados por su dios tribal, Huitzilopochtli,\nlos mexicas salieron de Aztlán en busca de\n"la señal" que indicaría el lugar para fundar\nMéxico-Tenochtitlan.',
          style: korolevFont.bodyText1,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  _logoContainer(size) {
    return Container(
      //largo y ancho del logo dentro
      width: double.infinity,
      height: size.height * 0.35,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/black_icon_container.png',
        ),
        filterQuality: FilterQuality.high,
      ),
      padding: EdgeInsets.only(
        top: size.height * 0.04,
      ),
    );
  }

  _backgroundDecoration() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/background_decoration1.png',
        ),
      ),
    );
  }

  _routeCurve() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/white_route_curve_background.png',
        ),
        color: Color.fromRGBO(255, 255, 255, 100),
      ),
    );
  }
  

  _logoLeaf() {
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/logo_leaf.png',
        ),
      ),
    );
  }
}

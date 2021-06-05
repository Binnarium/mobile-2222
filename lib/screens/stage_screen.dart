import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageScreen extends StatelessWidget {
  static const String route = '/stagescreen';
  

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          BackgroundWidget(backgroundColor: ColorsApp.backgroundOrange),          
          _backgroundDecoration(size),
          _routeCurve(size),
          _introductionBody(size),
          
          
          
        ],
      ),
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
            style: korolevFont.headline3
                ?.apply(fontSizeFactor: size.height * 0.0006,fontWeightDelta: -1)),
        SizedBox(height: size.height * 0.01),
        //Texto cambiar por funcionalidad de cuenta de días
        Text('AZTLÁN',
            style: korolevFont.headline1?.apply(fontSizeFactor: daysLeftSize,fontWeightDelta: 5)),
        SizedBox(height: size.height*0.05),    
        _logoContainer(size),
        SizedBox(height: size.height*0.07),   
        Text('Guiados por su dios tribal, Huitzilopochtli,\nlos mexicas salieron de Aztlán en busca de\n"la señal" que indicaría el lugar para fundar\nMéxico-Tenochtitlan.',
            style: korolevFont.bodyText1,
            textAlign: TextAlign.center,),    
    
      
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
          'assets/backgrounds/black_icon_container.png',
        ),
        filterQuality: FilterQuality.high,
      ),
      padding: EdgeInsets.only(
        top: size.height * 0.04,
      ),
    );
  }

  _backgroundDecoration(size) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: size.width,
      height: size.height,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/background_decoration1.png',

        ),
        
      ),
      
    );
  
  }
  _routeCurve(size) {
    return Container(
      alignment: Alignment.bottomCenter,
      width: size.width,
      height: size.height,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/white_route_curve_background.png',

        ),
        
      ),
      
    );
  
  }
}
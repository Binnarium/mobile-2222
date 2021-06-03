import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/src/themes/theme.dart';

class IntroductionPage extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    //tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      //creando pantalla introductoria
      body: Stack(
        children: [
          //llamando al background
          _background(),
          //llamando al widget del arco
          _arcContainer(),
          //llamando al cuerpo
          _introductionBody(size),
        ],
      ),
    );    
  }
  //Creando el background
  _background() {
    return Container(
      //largo y ancho
      width: double.infinity,
      height: double.infinity,
      //Color fondo de pantalla principal
      color: Color(0xffD52027),
    );
  }
  //Creando el cuerpo
  _introductionBody(Size size) {
    //Creando el Scroll
    var spacedSize = size.height*0.14;
    var daysLeftSize = size.height*0.001;
    if(size.height<550){
      spacedSize = size.height*0.08;
      daysLeftSize = size.height*0.0014;
    }
    return Column(
      children: [
        SizedBox(height: size.height * 0.03),
        //llamando el logo introductorio
        _logoIntro(size),
        //creando el espaciado necesario
        SizedBox(height: size.height * 0.03),
        //llamando el logo UTPL pantalla inicial
        _logoUtpl(size),
        //creando el espaciado necesario
        SizedBox(height: spacedSize),
        
        //Texto cambiar por funcionalidad de cuenta de días
        Text(
          'FALTAN',
          style: korolevFont.headline6?.apply(fontSizeFactor: size.height*0.001)  
          
        ),
        SizedBox(height: size.height * 0.01),
        //Texto cambiar por funcionalidad de cuenta de días
        Text(
          '56 DÍAS',
          style: korolevFont.headline3?.apply(fontSizeFactor: daysLeftSize)

          
        ),
        //Texto cambiar por funcionalidad de cuenta de días
        SizedBox(height: size.height * 0.005),
        Text(
          'PARA ACABAR EL VIAJE',
          style: korolevFont.headline6?.apply(fontSizeFactor: size.height*0.001)
        ),
        
        
      ],
    );
    
    
  }
  //Creando logo introductorio
  _logoIntro(Size size) {
    return Container(
      //largo y ancho del logo dentro
      width: double.infinity,
      height: size.height * 0.45,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/logo_background1.png',
        ),
        filterQuality: FilterQuality.high,
      ),
      padding: EdgeInsets.only(
        top: size.height * 0.04,
      ),
    );
  }
  //Creando logo UTPL pantalla introductoria
  _logoUtpl(Size size) {
    return Container(
      width: double.infinity,
      height: size.height * 0.17,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/logo_utpl1.png',
        ),
      ),
      padding: EdgeInsets.only(
        top: size.height * 0.02,
      ),
    );
  }
}
  //widget que contiene el arco
  _arcContainer() {
    return Container(
        width: double.infinity,
        height: double.infinity,
        child: CustomPaint(
          painter: _ArcPainter(),
        ));
  }
  //Creando arco pagina introductoria
  class _ArcPainter extends CustomPainter {
    
    @override
    void paint(Canvas canvas, Size size) {
      var uno = size.width*0.69;
      var dos = size.height*0.33;
      if(size.height<550){
        uno = size.height*0.45;
        dos = size.width*0.63;
      }
      
      var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width/2, size.height),
        height: dos,
        width: uno,
      ),
      pi,
      pi,
      false,
      paint1,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
  }




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
          _descriptionPageBody(),
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
    return Column(
      children: [
        //llamando el logo introductorio
        _logoIntro(size),
        //creando el espaciado necesario
        SizedBox(height: size.height * 0.03),
        //llamando el logo UTPL pantalla inicial
        _logoUtpl(size),
        //creando el espaciado necesario
        SizedBox(height: size.height * 0.139),
        //Texto cambiar por funcionalidad de cuenta de días
        Text(
          'FALTAN',
          style: korolevFont.headline6
          
          
        ),
        SizedBox(height: size.height * 0.01),
        //Texto cambiar por funcionalidad de cuenta de días
        Text(
          '56 DÍAS',
          style: korolevFont.headline3

          
        ),
        //Texto cambiar por funcionalidad de cuenta de días
        SizedBox(height: size.height * 0.005),
        Text(
          'PARA ACABAR EL VIAJE',
          style: korolevFont.headline6
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
      ),
      padding: EdgeInsets.only(
        top: size.height * 0.05,
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
  _descriptionPageBody() {
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
      var paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width/2, size.height*1.05),
        height: size.height*0.5,
        width: size.width*0.9,
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




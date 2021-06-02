import 'package:flutter/material.dart';

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
    return SingleChildScrollView(
      child: Column(
        children: [
          //llamando el logo introductorio
          _logoIntro(size),
          //creando el espaciado necesario
          SizedBox(height: size.height * 0.01),
          //llamando el logo UTPL pantalla inicial
          _logoUtpl(size),
          //creando el espaciado necesario
          SizedBox(height: size.height * 0.14),
          //Texto cambiar por funcionalidad de cuenta de días
          Text(
            'FALTAN',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Korolev',
                fontWeight: FontWeight.w500,
                fontSize: 25),
          ),
          //Texto cambiar por funcionalidad de cuenta de días
          Text(
            '56 DÍAS',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Korolev',
                fontWeight: FontWeight.w500,
                fontSize: 32),
          ),
          //Texto cambiar por funcionalidad de cuenta de días
          Text(
            'PARA ACABAR EL VIAJE',
            style: TextStyle(
                color: Colors.white,
                fontFamily: 'Korolev',
                fontWeight: FontWeight.w500,
                fontSize: 25),
          ),
          SizedBox(height: size.height * 0.05),
          
        ],
      ),
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
      height: size.height * 0.2,
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


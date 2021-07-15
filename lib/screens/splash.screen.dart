import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/login.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 15),
      () => Navigator.of(context).pushReplacementNamed(LoginScreen.route),
    );
  }

  @override
  Widget build(BuildContext context) {
    //tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    return Scaffold(
      /// define a color for all page since it is a single color page
      backgroundColor: ColorsApp.backgroundRed,

      /// creando pantalla introductoria
      body: Stack(
        children: [
          //llamando al widget del arco
          _arcContainer(),
          //llamando al cuerpo
          _introductionBody(size),
        ],
      ),
    );
  }

  _introductionBody(Size size) {
    //Creando el Scroll
    double spacedSize = size.height * 0.165;
    double daysLeftSize = size.height * 0.0011;
    if (size.height < 550) {
      spacedSize = size.height * 0.19;
      daysLeftSize = size.height * 0.0014;
    }
    if (size.height < 650) {
      spacedSize = size.height * 0.125;
      daysLeftSize = size.height * 0.0011;
    }
    return FutureBuilder(
      future: _daysLeftReading(),
      builder: (BuildContext context, AsyncSnapshot<String> days) {
        if (days.hasError) {
          return Text(days.error.toString());
        }
        if (days.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                ColorsApp.backgroundRed,
              ),
            ),
          );
        }
        if (days.hasData) {
          return Column(
            children: [
              SizedBox(height: size.height * 0.03),
              //llamando el logo introductorio
              _logoIntro(size),
              //creando el espaciado necesario
              SizedBox(height: size.height * 0.06),
              //llamando el logo UTPL pantalla inicial
              _logoUtpl(size),
              //creando el espaciado necesario
              SizedBox(height: spacedSize),

              //Texto cambiar por funcionalidad de cuenta de días
              Text('FALTAN',
                  style: korolevFont.headline6
                      ?.apply(fontSizeFactor: size.height * 0.001)),
              SizedBox(height: size.height * 0.01),
              //Texto cambiar por funcionalidad de cuenta de días

              Text(days.data! + " DÍAS",
                  style: korolevFont.headline3
                      ?.apply(fontSizeFactor: daysLeftSize)),

              //Texto cambiar por funcionalidad de cuenta de días
              SizedBox(height: size.height * 0.005),
              Text('PARA ACABAR EL VIAJE',
                  style: korolevFont.headline6
                      ?.apply(fontSizeFactor: size.height * 0.001)),
            ],
          );
        }
        return Text("Error loading daysleft _configuration_");
      },
    );
  }

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

//widget que contiene el arco
  _arcContainer() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: CustomPaint(
        painter: _ArcPainter(),
      ),
    );
  }

  Future<String> _daysLeftReading() async {
    final snap = await FirebaseFirestore.instance
        .collection('application')
        .doc('_configuration_')
        .get();

    if (!snap.exists)
      new ErrorDescription('Document _configuration_ does not exists');

    final Map<String, dynamic> payload = snap.data() as Map<String, dynamic>;
    final DateTime date =
        (payload['courseFinalizationDate'] as Timestamp).toDate();
    final Duration daysLeft = date.difference(DateTime.now());
    return daysLeft.inDays.toString();
  }
}

//Creando arco pagina introductoria
class _ArcPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double arcWidth = size.width * 0.69;
    double arcHeight = size.height * 0.33;
    if (size.height < 550) {
      arcWidth = size.height * 0.45;
      arcHeight = size.width * 0.63;
    }
    if (size.height < 650) {
      arcWidth = size.height * 0.45;
      arcHeight = size.width * 0.68;
    }

    Paint paint1 = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.width / 2, size.height),
        height: arcHeight,
        width: arcWidth,
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

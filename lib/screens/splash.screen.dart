import 'dart:async';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/login.screen.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

import 'home.screen.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // final bool _visible = true;
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 5),
      () => _createRoute(context),
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
      body: GestureDetector(
        onTap: () => _createRoute(context),
        child: Stack(
          children: [
            //llamando al widget del arco

            //llamando al cuerpo
            _introductionBody(size),
          ],
        ),
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
      ],
    );
  }

  void _createRoute(BuildContext context) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FutureBuilder(
            future: _initialization,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return StreamBuilder(
                  stream: FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.active) {
                      User? user = snapshot.data as User?;
                      if (user == null) {
                        return LoginScreen();
                      } else {
                        return HomeScreen();
                      }
                    }
                    return LoginScreen();
                  },
                );
              }
              return Scaffold(
                body: Center(
                  child: Text("Checking Authentication..."),
                ),
              );
            },
          );
        },
        transitionDuration: Duration(seconds: 5),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // var begin = Offset(0.0, 1.0);
          // var end = Offset.zero;
          // var curve = Curves.easeInQuart;

          // var tween =
          //     Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          // return SlideTransition(
          //   position: animation.drive(tween),
          //   child: child,
          // );
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}

_logoIntro(Size size) {
  return Container(
    //largo y ancho del logo dentro
    width: double.infinity,
    height: size.height * 0.45,
    child: AppLogo(
      kind: AppImage.animatedAppLogo,
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

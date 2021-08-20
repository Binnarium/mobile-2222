import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/screens/login.screen.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class SplashScreen extends StatefulWidget {
  static const String route = '/splash';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  StreamSubscription? redirectSub;

  @override
  void initState() {
    super.initState();

    /// authenticate user and redirect to correct screen
    this.redirectSub = UserService.instance.isSignIn$().listen((isSignIn) {
      if (isSignIn)
        Navigator.pushReplacementNamed(this.context, HomeScreen.route);
      else
        Navigator.pushReplacementNamed(this.context, LoginScreen.route);
    });
  }

  @override
  void deactivate() {
    this.redirectSub?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    //tamaño de la pantalla
    final size = MediaQuery.of(context).size;
    return Scaffold(
      /// define a color for all page since it is a single color page
      backgroundColor: Colors2222.red,

      /// creando pantalla introductoria
      body: _introductionBody(size),
    );
  }

  _introductionBody(Size size) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          /// llamando el logo introductorio
          Padding(
            padding: const EdgeInsets.only(top: 120, bottom: 80),
            child: AppLogo(
              width: min(400, size.width * 0.7),
              kind: AppImage.animatedAppLogo,
              filterQuality: FilterQuality.high,
            ),
          ),

          /// llamando el logo UTPL pantalla inicial
          Padding(
            padding: const EdgeInsets.only(bottom: 48),
            child: AppLogo(
              width: min(300, size.width * 0.5),
              kind: AppImage.utplLogo,
              filterQuality: FilterQuality.high,
            ),
          ),

          /// llamando el logo UTPL pantalla inicial
          AppLoading(),
        ],
      ),
    );
  }
}

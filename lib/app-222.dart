import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/app-provider.dart';
import 'package:lab_movil_2222/app-routing.dart';
import 'package:lab_movil_2222/screens/splash.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class App2222 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MaterialApp(
        title: 'Lab Móvil 2222',

        /// material app theme
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: KorolevFont.fontFamily,
          textTheme: KorolevFont(),
          primaryTextTheme: KorolevFont(textColor: Colors2222.black),
        ),

        initialRoute: SplashScreen.route,

        /// aquí van las páginas existentes, son las rutas a las páginas (pantallas)
        onGenerateRoute: (settings) => Lab2222Routing(settings),
      ),
    );
  }
}

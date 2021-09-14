import 'package:flutter/material.dart';

@Deprecated('Use Colors2222 instead')
typedef ColorsApp = Colors2222;

//Clase que contiene los colores de la aplicación
class Colors2222 {
  Colors2222._();

  static const Color primary = Colors2222.red;
  static const Color transparent = Color(0x00ffffff);

  static const Color white = Color(0xfffefefe);
  static const Color mapColor = Color(0xffefefef);

  static const Color red = Color(0xffD52027);
  static const Color black = Color(0xff000000);

  static Color grey = Colors2222.black.withOpacity(0.6);

  @Deprecated('use color red instead')
  static const Color backgroundRed = Color(0xffD52027);
  static const Color backgroundOrange = Color(0xffF1682A);
  static const Color backgroundBottomBar = Color(0xff242B30);
}

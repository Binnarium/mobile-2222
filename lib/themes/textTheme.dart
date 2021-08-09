import 'package:flutter/material.dart';

//Achivo que contiene los themes y fontstyles
//Font Korolev
@Deprecated('Use the theme of context utility instead')
final korolevFont = KorolevFont();

class KorolevFont extends TextTheme {
  static final String fontFamily = 'Korolev';

  KorolevFont({
    Color textColor = Colors.white,
  }) : super(
          headline1: TextStyle(
            fontFamily: fontFamily,
            fontSize: 96,
            color: textColor,
            fontWeight: FontWeight.w300,
          ),
          headline2: TextStyle(
            fontFamily: fontFamily,
            fontSize: 60,
            color: textColor,
            fontWeight: FontWeight.w300,
          ),
          headline3: TextStyle(
            fontFamily: fontFamily,
            fontSize: 48,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          headline4: TextStyle(
            fontFamily: fontFamily,
            fontSize: 34,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          headline5: TextStyle(
            fontFamily: fontFamily,
            fontSize: 24,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          headline6: TextStyle(
            fontFamily: fontFamily,
            fontSize: 20,
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
          subtitle1: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
          subtitle2: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            color: textColor,
            fontWeight: FontWeight.w700,
          ),
          bodyText1: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w300,
          ),
          bodyText2: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w600,
          ),
          caption: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        );
}

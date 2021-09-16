import 'dart:ui';

import 'package:flutter/material.dart';

/// Achivo que contiene los themes y fontstyles
/// Font Korolev
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
            fontSize: 44,
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
              fontWeight: FontWeight.w700,
              height: 1.1),
          subtitle2: TextStyle(
              fontFamily: fontFamily,
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.w700,
              height: 1.1),
          bodyText1: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w700,
            height: 1.3,
          ),
          bodyText2: TextStyle(
            fontFamily: fontFamily,
            fontSize: 16,
            color: textColor,
            fontWeight: FontWeight.w500,
            height: 1.3,
          ),
          caption: TextStyle(
            fontFamily: fontFamily,
            fontSize: 12,
            color: textColor,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          button: TextStyle(
            fontFamily: fontFamily,
            fontSize: 14,
            color: textColor,
            fontWeight: FontWeight.w700,
            height: 1.2,
          ),
          overline: TextStyle(
            fontFamily: fontFamily,
            fontSize: 10,
            color: textColor,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
        );
}

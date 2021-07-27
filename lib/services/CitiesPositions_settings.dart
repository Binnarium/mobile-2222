import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/cities-map.screen.dart';

Map<int, Positioned> getCitiesPositions(Size size, List<CityButton> buttons) {
  Map<int, Positioned> citiesButtonsPositions;
  if (size.width < 350) {
    return citiesButtonsPositions = {
      0: Positioned(
        child: buttons.elementAt(0),
        left: size.width * 0.27,
        bottom: size.height * 0.10,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.12,
        bottom: size.height * 0.22,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.26,
        bottom: size.height * 0.16,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.05,
        bottom: size.height * 0.23,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.39,
        bottom: size.height * 0.3,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.065,
        bottom: size.height * 0.37,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.22,
        bottom: size.height * 0.51,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.235,
        bottom: size.height * 0.445,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.085,
        top: size.height * 0.27,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.385,
        top: size.height * 0.195,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.12,
        top: size.height * 0.14,
      ),
      11: Positioned(
        child: buttons.elementAt(11),
        left: size.width * 0.435,
        top: size.height * 0.025,
      ),
    };
  }
  if (size.width < 370) {
    return citiesButtonsPositions = {
      0: Positioned(
        child: buttons.elementAt(0),
        left: size.width * 0.26,
        bottom: size.height * 0.09,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.10,
        bottom: size.height * 0.21,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.235,
        bottom: size.height * 0.155,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.03,
        bottom: size.height * 0.22,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.375,
        bottom: size.height * 0.29,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.05,
        bottom: size.height * 0.365,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.21,
        bottom: size.height * 0.51,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.22,
        bottom: size.height * 0.43,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.06,
        top: size.height * 0.26,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.37,
        top: size.height * 0.19,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.10,
        top: size.height * 0.135,
      ),
      11: Positioned(
        child: buttons.elementAt(11),
        left: size.width * 0.42,
        top: size.height * 0.02,
      ),
    };
  }
  if (size.width < 380 && size.height < 700) {
    return citiesButtonsPositions = {
      0: Positioned(
        child: buttons.elementAt(0),
        left: size.width * 0.26,
        bottom: size.height * 0.09,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.11,
        bottom: size.height * 0.21,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.245,
        bottom: size.height * 0.155,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.04,
        bottom: size.height * 0.23,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.38,
        bottom: size.height * 0.295,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.06,
        bottom: size.height * 0.37,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.21,
        bottom: size.height * 0.51,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.23,
        bottom: size.height * 0.44,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.07,
        top: size.height * 0.26,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.375,
        top: size.height * 0.19,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.105,
        top: size.height * 0.14,
      ),
      11: Positioned(
        child: buttons.elementAt(11),
        left: size.width * 0.42,
        top: size.height * 0.02,
      ),
    };
  }
  if (size.width < 380 && size.height < 820) {
    return citiesButtonsPositions = {
      0: Positioned(
        child: buttons.elementAt(0),
        left: size.width * 0.26,
        bottom: size.height * 0.11,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.11,
        bottom: size.height * 0.23,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.245,
        bottom: size.height * 0.17,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.04,
        bottom: size.height * 0.245,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.38,
        bottom: size.height * 0.31,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.055,
        bottom: size.height * 0.39,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.21,
        bottom: size.height * 0.53,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.225,
        bottom: size.height * 0.465,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.073,
        top: size.height * 0.275,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.375,
        top: size.height * 0.2,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.105,
        top: size.height * 0.145,
      ),
      11: Positioned(
        child: buttons.elementAt(11),
        left: size.width * 0.42,
        top: size.height * 0.03,
      ),
    };
  }
  if (size.width < 420 && size.height < 750) {
    return citiesButtonsPositions = {
      0: Positioned(
        child: buttons.elementAt(0),
        left: size.width * 0.27,
        bottom: size.height * 0.105,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.12,
        bottom: size.height * 0.22,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.25,
        bottom: size.height * 0.165,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.045,
        bottom: size.height * 0.24,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.39,
        bottom: size.height * 0.305,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.062,
        bottom: size.height * 0.383,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.22,
        bottom: size.height * 0.525,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.232,
        bottom: size.height * 0.455,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.08,
        top: size.height * 0.265,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.385,
        top: size.height * 0.195,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.115,
        top: size.height * 0.14,
      ),
      11: Positioned(
        child: buttons.elementAt(11),
        left: size.width * 0.43,
        top: size.height * 0.025,
      ),
    };
  }
  if (size.width < 420 && size.height < 850) {
    return citiesButtonsPositions = {
      0: Positioned(
        child: buttons.elementAt(0),
        left: size.width * 0.27,
        bottom: size.height * 0.11,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.12,
        bottom: size.height * 0.23,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.25,
        bottom: size.height * 0.17,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.047,
        bottom: size.height * 0.247,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.39,
        bottom: size.height * 0.31,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.065,
        bottom: size.height * 0.39,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.22,
        bottom: size.height * 0.535,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.232,
        bottom: size.height * 0.463,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.08,
        top: size.height * 0.275,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.385,
        top: size.height * 0.205,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.115,
        top: size.height * 0.15,
      ),
      11: Positioned(
        child: buttons.elementAt(11),
        left: size.width * 0.43,
        top: size.height * 0.03,
      ),
    };
  }
  return citiesButtonsPositions = {
    0: Positioned(
      child: buttons.elementAt(0),
      left: size.width * 0.275,
      bottom: size.height * 0.115,
    ),
    1: Positioned(
      child: buttons.elementAt(1),
      left: size.width * 0.125,
      bottom: size.height * 0.235,
    ),
    2: Positioned(
      child: buttons.elementAt(2),
      right: size.width * 0.255,
      bottom: size.height * 0.175,
    ),
    3: Positioned(
      child: buttons.elementAt(3),
      right: size.width * 0.05,
      bottom: size.height * 0.25,
    ),
    4: Positioned(
      child: buttons.elementAt(4),
      right: size.width * 0.395,
      bottom: size.height * 0.315,
    ),
    5: Positioned(
      child: buttons.elementAt(5),
      left: size.width * 0.065,
      bottom: size.height * 0.395,
    ),
    6: Positioned(
      child: buttons.elementAt(6),
      left: size.width * 0.22,
      bottom: size.height * 0.54,
    ),
    7: Positioned(
      child: buttons.elementAt(7),
      right: size.width * 0.237,
      bottom: size.height * 0.468,
    ),
    8: Positioned(
      child: buttons.elementAt(8),
      right: size.width * 0.085,
      top: size.height * 0.28,
    ),
    9: Positioned(
      child: buttons.elementAt(9),
      right: size.width * 0.385,
      top: size.height * 0.205,
    ),
    10: Positioned(
      child: buttons.elementAt(10),
      left: size.width * 0.115,
      top: size.height * 0.15,
    ),
    11: Positioned(
      child: buttons.elementAt(11),
      left: size.width * 0.435,
      top: size.height * 0.032,
    ),
  };
}

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/cities-map.screen.dart';

Map<int, Positioned> getCitiesPositions(Size size, List<MapCityButton> buttons) {
  Map<int, Positioned> citiesButtonsPositions;
  if (size.width < 350) {
    return citiesButtonsPositions = {
      0: Positioned(
        child: buttons.elementAt(0),
        left: size.width * 0.27,
        bottom: size.height * 0.12,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.12,
        bottom: size.height * 0.24,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.26,
        bottom: size.height * 0.18,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.05,
        bottom: size.height * 0.26,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.39,
        bottom: size.height * 0.33,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.065,
        bottom: size.height * 0.41,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.22,
        bottom: size.height * 0.57,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.235,
        bottom: size.height * 0.49,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.085,
        top: size.height * 0.29,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.385,
        top: size.height * 0.21,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.12,
        top: size.height * 0.16,
      ),
      11: Positioned(
        child: buttons.elementAt(11),
        left: size.width * 0.435,
        top: size.height * 0.027,
      ),
    };
  }
  if (size.width < 370) {
    return citiesButtonsPositions = {
      0: Positioned(
        child: buttons.elementAt(0),
        left: size.width * 0.28,
        bottom: size.height * 0.13,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.13,
        bottom: size.height * 0.25,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.27,
        bottom: size.height * 0.19,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.06,
        bottom: size.height * 0.27,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.4,
        bottom: size.height * 0.34,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.075,
        bottom: size.height * 0.42,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.23,
        bottom: size.height * 0.57,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.25,
        bottom: size.height * 0.5,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.09,
        top: size.height * 0.30,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.4,
        top: size.height * 0.22,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.13,
        top: size.height * 0.165,
      ),
      11: Positioned(
        child: buttons.elementAt(11),
        left: size.width * 0.44,
        top: size.height * 0.04,
      ),
    };
  }
  if (size.width < 380 && size.height < 700) {
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
        bottom: size.height * 0.175,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.04,
        bottom: size.height * 0.25,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.38,
        bottom: size.height * 0.315,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.06,
        bottom: size.height * 0.39,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.21,
        bottom: size.height * 0.55,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.23,
        bottom: size.height * 0.48,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.07,
        top: size.height * 0.28,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.375,
        top: size.height * 0.21,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.105,
        top: size.height * 0.16,
      ),
      11: Positioned(
        child: buttons.elementAt(11),
        left: size.width * 0.42,
        top: size.height * 0.03,
      ),
    };
  }
  if (size.width < 380 && size.height < 820) {
    return citiesButtonsPositions = {
      0: Positioned(
        child: buttons.elementAt(0),
        left: size.width * 0.26,
        bottom: size.height * 0.12,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.11,
        bottom: size.height * 0.25,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.245,
        bottom: size.height * 0.19,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.04,
        bottom: size.height * 0.265,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.38,
        bottom: size.height * 0.33,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.055,
        bottom: size.height * 0.42,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.21,
        bottom: size.height * 0.57,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.225,
        bottom: size.height * 0.495,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.073,
        top: size.height * 0.295,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.375,
        top: size.height * 0.22,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.105,
        top: size.height * 0.165,
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
        bottom: size.height * 0.115,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.12,
        bottom: size.height * 0.24,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.25,
        bottom: size.height * 0.185,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.045,
        bottom: size.height * 0.26,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.39,
        bottom: size.height * 0.325,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.062,
        bottom: size.height * 0.413,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.22,
        bottom: size.height * 0.565,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.232,
        bottom: size.height * 0.485,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.08,
        top: size.height * 0.285,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.385,
        top: size.height * 0.215,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.115,
        top: size.height * 0.16,
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
        bottom: size.height * 0.13,
      ),
      1: Positioned(
        child: buttons.elementAt(1),
        left: size.width * 0.12,
        bottom: size.height * 0.25,
      ),
      2: Positioned(
        child: buttons.elementAt(2),
        right: size.width * 0.25,
        bottom: size.height * 0.19,
      ),
      3: Positioned(
        child: buttons.elementAt(3),
        right: size.width * 0.047,
        bottom: size.height * 0.267,
      ),
      4: Positioned(
        child: buttons.elementAt(4),
        right: size.width * 0.39,
        bottom: size.height * 0.33,
      ),
      5: Positioned(
        child: buttons.elementAt(5),
        left: size.width * 0.065,
        bottom: size.height * 0.41,
      ),
      6: Positioned(
        child: buttons.elementAt(6),
        left: size.width * 0.22,
        bottom: size.height * 0.565,
      ),
      7: Positioned(
        child: buttons.elementAt(7),
        right: size.width * 0.232,
        bottom: size.height * 0.493,
      ),
      8: Positioned(
        child: buttons.elementAt(8),
        right: size.width * 0.08,
        top: size.height * 0.295,
      ),
      9: Positioned(
        child: buttons.elementAt(9),
        right: size.width * 0.385,
        top: size.height * 0.225,
      ),
      10: Positioned(
        child: buttons.elementAt(10),
        left: size.width * 0.115,
        top: size.height * 0.17,
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
      bottom: size.height * 0.125,
    ),
    1: Positioned(
      child: buttons.elementAt(1),
      left: size.width * 0.125,
      bottom: size.height * 0.255,
    ),
    2: Positioned(
      child: buttons.elementAt(2),
      right: size.width * 0.255,
      bottom: size.height * 0.195,
    ),
    3: Positioned(
      child: buttons.elementAt(3),
      right: size.width * 0.05,
      bottom: size.height * 0.27,
    ),
    4: Positioned(
      child: buttons.elementAt(4),
      right: size.width * 0.395,
      bottom: size.height * 0.335,
    ),
    5: Positioned(
      child: buttons.elementAt(5),
      left: size.width * 0.065,
      bottom: size.height * 0.415,
    ),
    6: Positioned(
      child: buttons.elementAt(6),
      left: size.width * 0.22,
      bottom: size.height * 0.57,
    ),
    7: Positioned(
      child: buttons.elementAt(7),
      right: size.width * 0.237,
      bottom: size.height * 0.498,
    ),
    8: Positioned(
      child: buttons.elementAt(8),
      right: size.width * 0.085,
      top: size.height * 0.3,
    ),
    9: Positioned(
      child: buttons.elementAt(9),
      right: size.width * 0.385,
      top: size.height * 0.225,
    ),
    10: Positioned(
      child: buttons.elementAt(10),
      left: size.width * 0.115,
      top: size.height * 0.17,
    ),
    11: Positioned(
      child: buttons.elementAt(11),
      left: size.width * 0.435,
      top: size.height * 0.032,
    ),
  };
}

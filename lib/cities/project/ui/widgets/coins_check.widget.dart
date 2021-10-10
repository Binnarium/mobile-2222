import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';

class CoinsCheckWidget extends StatefulWidget {
  const CoinsCheckWidget({
    Key? key,
    required this.coin,
    required this.hasMedal,
  }) : super(key: key);

  final MedalImage coin;
  final bool hasMedal;

  @override
  _CoinsCheckWidgetState createState() => _CoinsCheckWidgetState();
}

class _CoinsCheckWidgetState extends State<CoinsCheckWidget> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Image(
        image: widget.coin,
        alignment: Alignment.bottomRight,
        fit: BoxFit.contain,
        width: min(160, size.width * 0.4),
      ),
      Positioned(
        bottom: 0,
        right: 0,

        /// implements the widget to change the avatar
        /// logic is implemented on the button
        child: (widget.hasMedal)
            ? Icon(
                Icons.check_circle,
                color: Colors.green.shade900,
                size: 40,
              )
            : Container(),
      ),
    ]);
  }
}

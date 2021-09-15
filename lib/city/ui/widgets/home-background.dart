import 'package:flutter/material.dart';

/// background decoration used in the home screen so that there isn't some
/// unnecessary space with other color, and color behind the map
class HomeBackground extends Positioned {
  HomeBackground({
    Key? key,
  }) : super.fill(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// top decoration matching maps bottom
              Expanded(
                child: Image.asset(
                  'assets/backgrounds/map-background-top.png',
                  repeat: ImageRepeat.repeatY,
                ),
              ),

              /// bottom decoration matching maps bottom
              Expanded(
                child: Image.asset(
                  'assets/backgrounds/map-background-bottom.png',
                  repeat: ImageRepeat.repeatY,
                ),
              ),
            ],
          ),
        );
}

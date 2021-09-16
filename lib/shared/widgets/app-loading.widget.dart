import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double sideWidth = min(400, size.width * 0.3);

    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: sideWidth,
          maxHeight: sideWidth,
        ),
        child: AppLogo(
            kind: AppImage.loadingLogo,
            width: sideWidth,
            height: sideWidth,
            fit: BoxFit.contain,
            color: Colors2222.white),
      ),
    );
  }
}

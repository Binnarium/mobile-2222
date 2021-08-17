import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';

class AppLoading extends StatefulWidget {
  const AppLoading({
    Key? key,
  }) : super(key: key);

  @override
  _AppLoadingState createState() => _AppLoadingState();
}

class _AppLoadingState extends State<AppLoading> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
      value: 0,
      lowerBound: 0.2,
      upperBound: 1,
    );

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn);

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });
    _controller.forward();
  }

  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final double sideWidth = min(300, size.width * 0.2);

    return Container(
      width: sideWidth,
      height: sideWidth,
      child: FadeTransition(
        opacity: _animation,
        child: AppLogo(
          kind: AppImage.loadingLogo,
          width: sideWidth,
          height: sideWidth,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

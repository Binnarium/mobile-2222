import 'dart:async';

import 'package:flutter/material.dart';

class FadeInDelayed extends StatefulWidget {
  const FadeInDelayed({
    Key? key,
    required this.delay,
    required this.child,
  }) : super(key: key);

  final Duration delay;
  final Widget child;

  @override
  _FadeInDelayedState createState() => _FadeInDelayedState();
}

class _FadeInDelayedState extends State<FadeInDelayed> {
  bool visible = false;

  @override
  void initState() {
    super.initState();

    /// show after delay
    Timer(
      widget.delay,
      () => setState(() => visible = true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 500),
      opacity: visible ? 1 : 0,
      child: widget.child,
    );
  }
}

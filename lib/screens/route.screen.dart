import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class RouteScreen extends StatelessWidget {
  static const String route = '/route';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          BackgroundWidget(backgroundColor: ColorsApp.backgroundRed),
          Center(
            child: Text('Route Page'),
          ),
        ],
      ),
    );
  }
}

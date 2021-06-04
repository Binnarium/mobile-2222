import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class StatisticsScreen extends StatelessWidget {
  static const String route = '/stats';
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundWidget(backgroundColor: ColorsApp.backgroundRed),
        Center(
          child: Text('Statistics Page'),
        ),
      ],
    );
  }
}

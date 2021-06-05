import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class AccountScreen extends StatelessWidget {
  static const String route = '/account';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          BackgroundWidget(backgroundColor: ColorsApp.backgroundRed),
          Center(
            child: Text('Account Page'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/src/widgets/background_widget.dart';

class ClubHousePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundWidget(backgroundColor: Color(0xffD52027)),
        Center(
          child: Text('ClubHouse Page'),
        ),
      ],
    );
  }
}

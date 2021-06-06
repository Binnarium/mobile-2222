import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class StageArgumentationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            if (details.delta.dx > 0) {
              Navigator.pop(context);
            }
            // if (details.delta.dx < 0) {
            //   Navigator.push(context, MaterialPageRoute(builder: (context) {
            //     print('se movió a la derecha');
            //     return StageIntroductionScreen();
            //   },),);
            // }
          },
          child: Stack(
            children: [
              ChapterBackgroundWidget(
                  backgroundColor: ColorsApp.backgroundOrange),
              Text('Alv funcó')
            ],
          ),
        ),
      ),
    );
  }
}

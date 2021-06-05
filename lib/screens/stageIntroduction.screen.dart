import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class StageIntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 0) {
            Navigator.pop(context);
            print('Se movió a la izquierda');
          }
          // if (details.delta.dx < 0) {
          //   Navigator.push(context, MaterialPageRoute(builder: (context) {
          //     print('se movió a la derecha');
          //     return StageIntroductionScreen();
          //   }));
          // }
        },
        child: Stack(
          children: [
            BackgroundWidget(backgroundColor: ColorsApp.backgroundOrange),
            Center(
              child: Text('Pagina introduccion de chapter'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }
}

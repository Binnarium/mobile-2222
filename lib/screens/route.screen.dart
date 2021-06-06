import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageTitle.screen.dart';
import 'package:lab_movil_2222/shared/widgets/background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
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
            child: Stack(
              children: [
                //background
                BackgroundWidget(backgroundColor: ColorsApp.backgroundOrange),
                //body de las rutas (el mapa)
                _routeBody(context),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  _routeBody(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(ColorsApp.backgroundBottomBar),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return StageTitleScreen();
          }));
        },
        child: Text('Cap 1'),
      ),
    );
  }
}

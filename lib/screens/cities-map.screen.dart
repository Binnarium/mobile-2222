import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/cities.screen.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class CitiesMapScreen extends StatefulWidget {
  static const String route = '/cities-map';

  @override
  _CitiesMapScreenState createState() => _CitiesMapScreenState();
}

class _CitiesMapScreenState extends State<CitiesMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushReplacementNamed(CitiesScreen.route),
        child: Icon(Icons.local_activity),
      ),
      appBar: AppBar(
        elevation: 10,
        backgroundColor: ColorsApp.backgroundBottomBar,
        backwardsCompatibility: false,
        leading: Container(),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, HomeScreen.route);
              },
              icon: Icon(Icons.help_outline_rounded))
        ],
      ),
      body: _citiesView(context),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  Stack _citiesView(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Stack(
            children: [
              //background
              CustomBackground(backgroundColor: Color(0xff353839)),
              //body de las rutas (el mapa)
              SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: Container(
                  color: ColorsApp.white,
                  child: Stack(
                    children: [
                      Image.asset(
                        'assets/images/map_wip.png',
                        fit: BoxFit.contain,
                        width: double.infinity,
                      ),
                      Positioned.fill(
                        child: Container(
                          color: Colors.black.withAlpha(35),
                        ),
                      ),
                      Positioned.fill(
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              'Mapa aun en Desarrollo. Esperalo Próximamente',
                              style: korolevFont.headline5,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

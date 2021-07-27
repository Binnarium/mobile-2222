import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/cities.screen.dart';
import 'package:lab_movil_2222/services/CitiesPositions_settings.dart';
import 'package:lab_movil_2222/shared/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

import 'chapter_screens/stageIntroduction.screen.dart';

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
      body: _citiesView(context),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  _citiesView(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder(
        future: _readChapterConfigurations(),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            print(snapshot.error);
            return Center(child: Text('Ocurrió un error'));
          }
          if (snapshot.data == null)
            return Center(
                child: Text(
              'Cargando...',
              style: korolevFont.bodyText1,
            ));

          final List<CityDto> data = snapshot.data as List<CityDto>;
          return Stack(
            children: [
              Center(
                child: Stack(
                  children: [
                    Container(
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/map_wip.png',
                            fit: BoxFit.fill,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                          Stack(
                            children: _citiesButtons(data, size),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  List<Positioned> _citiesButtons(
      List<CityDto> data, Size size) {
    List<CityButton> buttons = [];

    for (var i = 0; i < data.length; i++) {
      buttons.add(new CityButton(settings: data[i]));
    }

    Map<int, Positioned> citiesButtonsPositions =
        getCitiesPositions(size, buttons);
    List<Positioned> positionedButtons = [];
    citiesButtonsPositions.forEach((key, value) {
      positionedButtons.add(value);
    });
    return positionedButtons;
  }

  Future<List<CityDto>> _readChapterConfigurations() async {
    ///  reading chapter configurations

    List<CityDto> settingsTemp = [];

    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .orderBy("stage")
        .get();
    final settings = snap.docs
        .map((e) => CityDto.fromMap(e.data()))
        .toList();
    settingsTemp = settings;
    return settingsTemp;
  }
}

class CityButton extends StatelessWidget {
  final CityDto settings;
  const CityButton({Key? key, required this.settings}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        print("Presionado: ${this.settings.name}");
        Navigator.pushNamed(
          context,
          StageIntroductionScreen.route,
          arguments: StageIntroductionScreen(
            chapterSettings: settings,
          ),
        );
      },
      child: Container(),
      style: ElevatedButton.styleFrom(
        shape: CircleBorder(),
        padding: (size.width <= 360) ? EdgeInsets.all(35) : EdgeInsets.all(45),
        // onPrimary: Colors.white,
        primary: Colors.transparent,
        shadowColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}

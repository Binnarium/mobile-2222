import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/screens/cities-map.screen.dart';
import 'package:lab_movil_2222/shared/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

import 'home.screen.dart';

class CitiesScreen extends StatefulWidget {
  static const String route = '/cities';

  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              icon: Icon(Icons.home))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).pushReplacementNamed(CitiesMapScreen.route),
        child: Icon(Icons.local_activity),
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
              _routeBody(context),
            ],
          ),
        ),
      ],
    );
  }

  _routeBody(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FutureBuilder(
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
          // return builded component
          return GridView.builder(
            padding: EdgeInsets.all(24),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 12 / 9,
            ),
            itemBuilder: (context, i) => Material(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              clipBehavior: Clip.hardEdge,
              color: data[i].color,
              child: InkWell(
                splashColor: data[i].color.withAlpha(150),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    StageIntroductionScreen.route,
                    arguments: StageIntroductionScreen(
                      chapterSettings: data[i],
                    ),
                  );
                },
                child: Stack(
                  children: [
                    Positioned(
                      child: Opacity(
                        opacity: 0.8,
                        child: Hero(
                          tag: data[i].icon.path,
                          child: Image.network(
                            data[i].icon.url,
                            width: 120,
                            height: 120,
                          ),
                        ),
                      ),
                      top: -30,
                      right: -40,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${(i + 1)}. ${(data[i].name)}",
                            style: korolevFont.headline6,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            itemCount: data.length,
          );
        },
      ),
    );
  }

  Future<List<CityDto>> _readChapterConfigurations() async {
    ///  reading chapter configurations

    List<CityDto> settingsTemp = [];

    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .orderBy("stage")
        .get();

    final settings = snap.docs.map((e) => CityDto.fromMap(e.data())).toList();
    settingsTemp = settings;
    return settingsTemp;
  }
}

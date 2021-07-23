import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
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

          final List<FirebaseChapterSettings> data =
              snapshot.data as List<FirebaseChapterSettings>;
          // return builded component
          return ListView.separated(
            itemCount: data.length,
            separatorBuilder: (context, index) => Container(height: 12),
            itemBuilder: (context, i) => ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 12, horizontal: 20)),
                backgroundColor:
                    MaterialStateProperty.all(Color(data[i].primaryColor)),
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  StageIntroductionScreen.route,
                  arguments: StageIntroductionScreen(
                    chapterSettings: data[i],
                  ),
                );
              },
              child: Row(
                children: [
                  Image.network(data[i].chapterImageUrl, width: 30),
                  Container(width: 10),
                  Text("${(i + 1)}. ${(data[i].cityName)}"),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Future<List<FirebaseChapterSettings>> _readChapterConfigurations() async {
    ///  reading chapter configurations

    List<FirebaseChapterSettings> settingsTemp = [];

    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .orderBy("stage")
        .get();
    final settings = snap.docs
        .map((e) => FirebaseChapterSettings.fromJson(e.data()))
        .toList();
    settingsTemp = settings;
    return settingsTemp;
  }
}

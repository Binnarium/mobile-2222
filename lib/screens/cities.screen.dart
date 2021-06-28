import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/shared/models/ChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class CitiesScreen extends StatefulWidget {
  static const String route = '/cities';

  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  Map<String, dynamic> _items = new Map();

  @override
  void initState() {
    readJson();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: Stack(
              children: [
                //background
                CustomBackground(backgroundColor: ColorsApp.backgroundOrange),
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
    return Container(
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorsApp.backgroundBottomBar),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return StageIntroductionScreen(
                  chapterSettings: ChapterSettings.fromJson(_items["chapter1"]),
                );
              }));
            },
            child: Text('Cap 1'),
          ),
        ],
      ),
    );
  }

  /// fetch the json in assets
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString('assets/json/chapter.settings.json');
    final data = await json.decode(response);
    setState(() {
      _items = data;
    });
  }
}

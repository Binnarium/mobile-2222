import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageTitle.screen.dart';
import 'package:lab_movil_2222/shared/models/ChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class RouteScreen extends StatefulWidget {
  static const String route = '/route';

  @override
  _RouteScreenState createState() => _RouteScreenState();
}

class _RouteScreenState extends State<RouteScreen> {
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
                return StageTitleScreen(
                  chapterSettings: ChapterSettings.fromJson(_items["chapter1"]),
                );
              }));
            },
            child: Text('Cap 1'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorsApp.backgroundBottomBar),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return StageTitleScreen(
                  chapterSettings: ChapterSettings.fromJson(_items["chapter2"]),
                );
              }));
            },
            child: Text('Cap 2'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorsApp.backgroundBottomBar),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return StageTitleScreen(
                  chapterSettings: ChapterSettings.fromJson(_items["chapter5"]),
                );
              }));
            },
            child: Text('Cap 5'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorsApp.backgroundBottomBar),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return StageTitleScreen(
                  chapterSettings: ChapterSettings.fromJson(_items["chapter6"]),
                );
              }));
            },
            child: Text('Cap 6'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorsApp.backgroundBottomBar),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return StageTitleScreen(
                  chapterSettings: ChapterSettings.fromJson(_items["chapter8"]),
                );
              }));
            },
            child: Text('Cap 8'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorsApp.backgroundBottomBar),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return StageTitleScreen(
                  chapterSettings:
                      ChapterSettings.fromJson(_items["chapter10"]),
                );
              }));
            },
            child: Text('Cap 10'),
          ),
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all(ColorsApp.backgroundBottomBar),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return StageTitleScreen(
                  chapterSettings:
                      ChapterSettings.fromJson(_items["chapter12"]),
                );
              }));
            },
            child: Text('Cap 12'),
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

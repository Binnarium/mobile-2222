import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class CitiesScreen extends StatefulWidget {
  static const String route = '/cities';

  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  List settings = [];

  @override
  void initState() {
    _asyncLecture();
    super.initState();
  }

  void _asyncLecture() async {
    settings = await _readChapterConfigurations();
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
                  chapterSettings: settings[0],
                );
              }));
            },
            child: Text('Cap 1'),
          ),
        ],
      ),
    );
  }

  Future<List<FirebaseChapterSettings>> _readChapterConfigurations() async {
    List<FirebaseChapterSettings> settings = [];

    ///  reading chapter configurations
    await FirebaseFirestore.instance
        .collection('cities')
        .orderBy("stage")
        .get()
        .then(
      (QuerySnapshot querySnapshot) {
        querySnapshot.docs.toList().asMap().forEach(
          (index, doc) {
            final confTemp = new FirebaseChapterSettings(
              id: doc["id"],
              primaryColor: doc["configuration"]["colorHex"],
              phaseName: "etapa " + doc["stage"].toString(),
              cityName: doc["name"],
              chapterImageUrl: doc["iconUrl"],
            );
            print(confTemp.toJson());
            // print('${doc['configuration']}');
            settings.add(confTemp);

            // print('Lo que viene de firebase: ${doc.data().toString()}');
          },
        );
      },
    );
    return settings;

    // /// 2da forma
    // FirebaseFirestore.instance
    //     .collection('cities')
    //     .doc('quitu')
    //     .collection('pages')
    //     .doc('objective')
    //     .get()
    //     .then(
    //   (DocumentSnapshot documentSnapshot) {
    //     if (documentSnapshot.exists) {
    //       dynamic data = documentSnapshot.data()!;
    //       /// to access to firebase reference
    //       List<DocumentReference> ideasRef = (data['ideas'] as List<dynamic>)
    //           .map((e) => e as DocumentReference)
    //           .toList();
    //       for (var i = 0; i < ideasRef.length; i++) {
    //         var idea = ideasRef[i];
    //         idea.get().then((value) => print(value.data().toString()));
    //       }
    //       print(documentSnapshot.data().toString());
    //     }
    //   },
    // );
  }
}

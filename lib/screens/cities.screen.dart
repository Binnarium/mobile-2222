
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';

class CitiesScreen extends StatefulWidget {
  static const String route = '/cities';

  @override
  _CitiesScreenState createState() => _CitiesScreenState();
}

class _CitiesScreenState extends State<CitiesScreen> {
  @override
  void initState() {
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
                CustomBackground(backgroundColor: Color(0xff353839)),
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
      child: FutureBuilder(
        future: _readChapterConfigurations(),
        builder: (context, snapshot) {
          if (snapshot.error != null) {
            print(snapshot.error);
            return Center(child: Text('Ocurrió un error'));
          }
          if (snapshot.data == null) return Center(child: Text('Cargando...'));

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
                  Text(data[i].cityName),
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
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('cities')
        .orderBy("stage")
        .get();
    List<FirebaseChapterSettings> settings = querySnapshot.docs.map(
      (element) {
        final data = element.data() as Map<String, dynamic>;
        final confTemp = new FirebaseChapterSettings(
          id: data["id"],
          primaryColor: data["configuration"]["colorHex"],
          phaseName: "etapa " + data["stage"].toString(),
          cityName: data["name"],
          chapterImageUrl: data["iconUrl"],
        );
        return confTemp;
      },
    ).toList();

    return settings;
  }
}

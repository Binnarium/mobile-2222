import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageArgumentation.screen.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';

class StageMonsterScreen extends StatefulWidget {
  static const String route = '/monster';
  final CityDto city;

  const StageMonsterScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  _StageMonsterScreenState createState() => _StageMonsterScreenState();
}

class _StageMonsterScreenState extends State<StageMonsterScreen> {
  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        StageArgumentationScreen.route,
        arguments: StageArgumentationScreen(
          chapterSettings: this.widget.city,
        ),
      );
    };

    Size size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onPanUpdate: (details) {
            /// left
            if (details.delta.dx > 5) prevPage();

            /// right
            if (details.delta.dx < -5) nextPage();
          },
          child: Stack(
            children: [
              //widget custom que crea el background con el logo de la izq
              ChapterBackgroundWidget(
                backgroundColor: widget.city.color,
                reliefPosition: 'top-right',
              ),
              //decoración adicional del background
              _backgroundDecoration(size),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  _backgroundDecoration(Size size) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ChapterHeadWidget(
          showAppLogo: true,
          showStageLogo: true,
          city: this.widget.city,
        ),
        Expanded(
          child: Center(
            child: _ghostImage(size),
          ),
        )
      ],
    );
  }

  _ghostImage(Size size) {
    return FutureBuilder(
      future: _readIlustrationURL(),
      builder: (BuildContext context, AsyncSnapshot<String> url) {
        if (url.hasError) {
          return Text(url.error.toString());
        }

        if (url.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                Colors.white,
              ),
            ),
          );
        }
        return Align(
          alignment: Alignment.center,
          child: Container(
            // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
            margin: EdgeInsets.symmetric(
                vertical: size.height * 0.1, horizontal: size.width * 0.1),
            child: Container(
              width: size.width * 0.8,
              height: size.height * 0.7,
              child: Image(
                fit: BoxFit.contain,
                image: NetworkImage(
                  url.data.toString(),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<String> _readIlustrationURL() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.city.id)
        .collection('pages')
        .doc('argument')
        .get();

    if (!snap.exists)
      new ErrorDescription(' URL of Illustration does not exists');

    String url = snap.get('illustration')['url'].toString();

    return url;
  }
}

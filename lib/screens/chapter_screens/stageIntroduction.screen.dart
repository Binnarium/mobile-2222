import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageIntroductionScreen extends StatefulWidget {
  static const String route = '/introduction';
  final FirebaseChapterSettings chapterSettings;

  const StageIntroductionScreen({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);

  @override
  _StageIntroductionScreenState createState() =>
      _StageIntroductionScreenState();
}

class _StageIntroductionScreenState extends State<StageIntroductionScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StageHistoryScreen(
          chapterSettings: this.widget.chapterSettings,
        );
      }));
    };

    // Navigator.pushNamed(context, StageIntroductionScreen.route);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          /// left
          if (details.delta.dx > 5) prevPage();

          /// right
          if (details.delta.dx < -5) nextPage();
        },

        /// main content of page
        /// the content includes a background with images, and scroll-able content
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// first layer is the background with road-map
            ChapterBackgroundWidget(
              backgroundColor: Color(widget.chapterSettings.primaryColor),
              reliefPosition: 'bottom-right',
            ),

            /// scroll-able content
            _introductionBody(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  _introductionBody(Size size) {
    //Creando el Scroll
    double spacedSize = size.height * 0.08;
    double fontSize = (size.height > 700) ? 1.2 : 1.1;
    double bodyMarginLeft = size.width * 0.05;
    if (size.height < 550) {
      spacedSize = size.height * 0.15;
    }
    if (size.height < 650) {
      spacedSize = size.height * 0.08;
    }
    return ListView(
      /// city logo
      children: [
        ChapterHeadWidget(
          phaseName: 'introduction',
        ),
        SizedBox(height: spacedSize),
        //Texto cambiar por funcionalidad de cuenta de días
        Text(this.widget.chapterSettings.phaseName.toUpperCase(),
            textAlign: TextAlign.center,
            style: korolevFont.headline3
                ?.apply(fontSizeFactor: fontSize - 0.5, fontWeightDelta: -1)),
        SizedBox(height: 10),
        //Texto cambiar por funcionalidad de cuenta de días
        Text(this.widget.chapterSettings.cityName.toUpperCase(),
            textAlign: TextAlign.center,
            style: korolevFont.headline1
                ?.apply(fontSizeFactor: fontSize - 0.5, fontWeightDelta: 5)),
        SizedBox(height: size.height * 0.05),
        _logoContainer(size),
        SizedBox(height: size.height * 0.07),
        FutureBuilder(
          future: _readIntroductionText(),
          builder: (BuildContext context, AsyncSnapshot<String> readings) {
            if (readings.hasError) {
              return Text(readings.error.toString());
            }

            if (readings.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(this.widget.chapterSettings.primaryColor),
                  ),
                ),
              );
            }
            return Container(
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                readings.data.toString(),
                style: korolevFont.bodyText1?.apply(fontSizeFactor: fontSize),
                textAlign: TextAlign.center,
              ),
            );
          },
        ),
        SizedBox(height: size.height * 0.07),
      ],
    );
  }

  _logoContainer(size) {
    return Container(
      //largo y ancho del logo dentro
      width: double.infinity,
      height: size.height * 0.35,
      child: Image(
        image: NetworkImage(
          this.widget.chapterSettings.chapterImageUrl,
        ),
        filterQuality: FilterQuality.high,
      ),
      padding: EdgeInsets.only(
        top: size.height * 0.04,
      ),
    );
  }

  Future<String> _readIntroductionText() async {
    String description = "";
    await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('introduction')
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          dynamic data = documentSnapshot.data()!;
          description = data['description'].toString();
        }
      },
    );
    // print('description antes de enviar: $description');
    return description;
  }
}

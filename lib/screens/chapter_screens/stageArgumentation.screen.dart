import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/idea_container_widget.dart';

class StageArgumentationScreen extends StatefulWidget {
  static const String route = '/argumentation';
  final FirebaseChapterSettings chapterSettings;

  const StageArgumentationScreen({Key? key, required this.chapterSettings})
      : super(key: key);

  @override
  _StageArgumentationScreenState createState() =>
      _StageArgumentationScreenState();
}

class _StageArgumentationScreenState extends State<StageArgumentationScreen> {
  @override
  void initState() {
    _asyncLecture();
    super.initState();
  }

  void _asyncLecture() async {
    await _readIdeas();
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        StageObjetivesScreen.route,
        arguments: StageObjetivesScreen(
          chapterSettings: this.widget.chapterSettings,
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
                backgroundColor: Color(widget.chapterSettings.primaryColor),
                reliefPosition: 'top-right',
              ),
              //decoración adicional del background
              _backgroundDecoration(size),
              _ideas(size),
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
    return Container(
      width: size.width,
      height: size.height,
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: ListView(children: [
        ChapterHeadWidget(
          phaseName: this.widget.chapterSettings.phaseName,
          chapterName: this.widget.chapterSettings.cityName,
          chapterImgURL: this.widget.chapterSettings.chapterImageUrl,
        ),
        _ghostImage(size),
      ]),
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
        return Container(
          alignment: Alignment.bottomCenter,
          padding: EdgeInsets.symmetric(horizontal: 20),
          width: size.width,
          height: size.height * 0.75,
          child: Image(
            image: NetworkImage(
              url.data.toString(),
            ),
          ),
        );
      },
    );
  }

  _ideas(Size size) {
    double widthFactor = (size.height > 700) ? 0.4 : 0.36;
    double heightFactor = (size.height > 700) ? 0.15 : 0.15;
    return FutureBuilder(
      future: _readIdeas(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> ideas) {
        if (ideas.hasError) {
          return Text(ideas.error.toString());
        }

        if (ideas.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(
                Color(this.widget.chapterSettings.primaryColor),
              ),
            ),
          );
        }
        return Stack(
          children: [
            Positioned(
              top: (size.height > 700) ? size.height * 0.18 : size.height * 0.2,
              left: (size.height > 700) ? size.width * 0.25 : size.width * 0.3,
              child: IdeaContainerWidget(
                text: ideas.data!.elementAt(0),
                width: size.width * widthFactor,
                height: size.height * heightFactor,
              ),
            ),
            Positioned(
              top:
                  (size.height > 700) ? size.height * 0.33 : size.height * 0.33,
              left: size.width * 0.02,
              child: IdeaContainerWidget(
                text: ideas.data!.elementAt(1),
                width: size.width * widthFactor,
                height: size.height * heightFactor,
                isTopRight: true,
              ),
            ),
            Positioned(
              top: (size.height > 700) ? size.height * 0.3 : size.height * 0.3,
              left: (size.height > 700) ? size.width * 0.6 : size.width * 0.62,
              child: IdeaContainerWidget(
                text: ideas.data!.elementAt(2),
                width: size.width * widthFactor,
                height: size.height * heightFactor,
                isTopLeft: true,
              ),
            ),
          ],
        );
      },
    );
  }

  Future<List<dynamic>> _readIdeas() async {
    List<dynamic> ideasTemp = [];
    await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('argument')
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          ideasTemp = documentSnapshot.get('ideas');
          // print('ideas temp : $ideasTemp');
        }
      },
    );
    return ideasTemp;
  }

  Future<String> _readIlustrationURL() async {
    String url = "";
    await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('argument')
        .get()
        .then(
      (DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          url = documentSnapshot.get('illustrationUrl').toString();
          // print('ideas temp : $url');
        }
      },
    );
    return url;
  }
}

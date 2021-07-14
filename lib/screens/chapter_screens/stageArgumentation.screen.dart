import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    await _readQuestions();
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
              // _ideas(size),
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
          height: size.height * 0.825,
          // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            child: Stack(children: [
              Container(
                // decoration:
                // BoxDecoration(border: Border.all(color: Colors.green)),
                alignment: Alignment.bottomLeft,
                child: Image(
                  // alignment: Alignment.bottomLeft,
                  width: size.width * 0.8,
                  image: NetworkImage(
                    url.data.toString(),
                  ),
                ),
              ),
              _ideas(size),
            ]),
          ),
        );
      },
    );
  }

  _ideas(Size size) {
    double widthFactor = (size.height > 800)
        ? 0.5
        : (size.height > 700)
            ? 0.45
            : 0.4;
    double heightFactor = (size.height > 800)
        ? 0.2
        : (size.height > 700)
            ? 0.2
            : 0.2;
    return FutureBuilder(
      future: _readQuestions(),
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
        List<Align> bubbles = [];
        for (var i = 0; i < ideas.data!.length; i++) {
          if (ideas.data?.elementAt(i) != null) {
            Align bubble = _createBubble(
                i, ideas.data?.elementAt(i), size, widthFactor, heightFactor);
            bubbles.add(bubble);
          }
        }
        return Stack(
          children: bubbles,
        );
      },
    );
  }

  Future<List<dynamic>> _readQuestions() async {
    List<dynamic> ideasTemp = [];
    final data = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('argument')
        .get();

    if (data.exists) {
      ideasTemp = data.get('questions');
    }

    return ideasTemp;
  }

  Future<String> _readIlustrationURL() async {
    final snap = await FirebaseFirestore.instance
        .collection('cities')
        .doc(this.widget.chapterSettings.id)
        .collection('pages')
        .doc('argument')
        .get();

    if (!snap.exists)
      new ErrorDescription(' URL of Illustration does not exists');

    String url = snap.get('illustration')['url'].toString();

    return url;
  }

  Align _createBubble(
      int i, String idea, Size size, double width, double height) {
    Map<int, Alignment> aligns = {
      0: Alignment(-0.8, -0.7),
      1: (size.width > 400) ? Alignment(0.9, -0.3) : Alignment(0.9, -0.2),
      2: (size.height > 800) ? Alignment(0.9, 0.8) : Alignment(0.9, 0.7),
      3: Alignment(-1, 0.8),
      4: Alignment(1, 0.8),
    };
    Map<int, String> orientations = {
      0: "TopRight",
      1: "CenterLeft",
      2: "BottomLeft",
      3: "TopRight",
      4: "TopLeft",
    };
    return Align(
      alignment: aligns[i]!,
      child: IdeaContainerWidget(
        text: idea,
        width: size.width * width,
        height: size.height * height,
        orientation: orientations[i],
      ),
    );
  }
}

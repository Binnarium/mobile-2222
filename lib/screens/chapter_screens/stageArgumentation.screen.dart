import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/services/i-load-with-options.service.dart';
import 'package:lab_movil_2222/services/load-arguments-screen-information.service.dart';
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
  List<dynamic>? questions;
  @override
  void initState() {
    super.initState();
    ILoadInformationWithOptions<List<dynamic>, FirebaseChapterSettings> loader =
        LoadArgumentScreenInformationService(
            chapterSettings: this.widget.chapterSettings);
    loader.load().then((value) => this.setState(() => questions = value));
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
        SizedBox(
          height: 10,
        ),
        ChapterHeadWidget(
          phaseName: this.widget.chapterSettings.phaseName,
          chapterName: this.widget.chapterSettings.cityName,
          chapterImgURL: this.widget.chapterSettings.chapterImageUrl,
        ),
        Container(
          height: size.height * 0.825,
          // decoration: BoxDecoration(border: Border.all(color: Colors.green)),
          // padding: EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            child: Stack(children: [
              _ideas(size),
            ]),
          ),
        ),
      ]),
    );
  }

  _ideas(Size size) {
    double widthFactor = (size.height > 800)
        ? 0.5
        : (size.height > 700)
            ? 0.45
            : 0.5;
    double heightFactor = (size.height > 800)
        ? 0.2
        : (size.height > 700)
            ? 0.2
            : 0.25;

    if (questions == null) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            Color(this.widget.chapterSettings.primaryColor),
          ),
        ),
      );
    }
    List<Align> bubbles = [];
    for (var i = 0; i < questions!.length; i++) {
      if (questions!.elementAt(i) != null) {
        Align bubble = _createBubble(
            i, questions!.elementAt(i), size, widthFactor, heightFactor);
        bubbles.add(bubble);
      }
    }
    return Stack(
      children: bubbles,
    );
  }

  Align _createBubble(
      int i, String idea, Size size, double width, double height) {
    Map<int, Alignment> aligns = {
      0: Alignment(-0.8, -0.5),
      1: (size.height > 800) ? Alignment(0.9, -0.1) : Alignment(0.9, 0),
      2: (size.height > 800) ? Alignment(-0.9, 0.3) : Alignment(-0.9, 0.45),
      3: (size.height > 800) ? Alignment(0.9, -0.9) : Alignment(0.9, -0.95),
      4: (size.height > 800) ? Alignment(0.9, 0.7) : Alignment(0.9, 0.9),
    };
    Map<int, String> orientations = {
      0: "TopRight",
      1: "CenterLeft",
      2: "BottomRight",
      3: "TopLeft",
      4: "BottomLeft",
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

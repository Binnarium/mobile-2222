import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/shared/models/FirebaseChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/idea_container_widget.dart';

class StageArgumentationScreen extends StatelessWidget {
  static const String route = '/argumentation';
  final FirebaseChapterSettings chapterSettings;

  const StageArgumentationScreen({Key? key, required this.chapterSettings})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StageObjetivesScreen(
          chapterSettings: this.chapterSettings,
        );
      }));
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
                backgroundColor: Color(chapterSettings.primaryColor),
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
          phaseName: this.chapterSettings.phaseName,
          chapterName: this.chapterSettings.cityName,
          chapterImgURL: this.chapterSettings.chapterImageUrl,
        ),
        _ghostImage(size),
      ]),
    );
  }

  _ghostImage(Size size) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width,
      height: size.height * 0.75,
      child: Image(
        image: AssetImage(
          "assets/backgrounds/decorations/Phasm_background_decoration.png",
        ),
      ),
    );
  }

  _ideas(Size size) {
    double widthFactor = (size.height > 700) ? 0.4 : 0.36;
    double heightFactor = (size.height > 700) ? 0.15 : 0.15;
    return Stack(children: [
      Positioned(
        top: (size.height > 700) ? size.height * 0.18 : size.height * 0.2,
        left: (size.height > 700) ? size.width * 0.25 : size.width * 0.3,
        child: IdeaContainerWidget(
          text:
              '¿Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequu?',
          width: size.width * widthFactor,
          height: size.height * heightFactor,
        ),
      ),
      Positioned(
        top: (size.height > 700) ? size.height * 0.33 : size.height * 0.33,
        left: size.width * 0.02,
        child: IdeaContainerWidget(
          text:
              '¿Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequu?',
          width: size.width * widthFactor,
          height: size.height * heightFactor,
          isTopRight: true,
        ),
      ),
      Positioned(
        top: (size.height > 700) ? size.height * 0.3 : size.height * 0.3,
        left: (size.height > 700) ? size.width * 0.6 : size.width * 0.62,
        child: IdeaContainerWidget(
          text:
              '¿Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequu?',
          width: size.width * widthFactor,
          height: size.height * heightFactor,
          isTopLeft: true,
        ),
      ),
    ]);
  }
}

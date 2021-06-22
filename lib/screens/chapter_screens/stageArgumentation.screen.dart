import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/shared/models/ChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/idea_container_widget.dart';

class StageArgumentationScreen extends StatelessWidget {
  static const String route = '/argumentation';
  final ChapterSettings chapterSettings;

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
                backgroundColor: Color(int.parse(chapterSettings.primaryColor)),
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
          this.chapterSettings.characterImageUrl,
        ),
      ),
    );
  }

  _ideas(Size size) {
    double widthFactor = (size.height > 700) ? 0.38 : 0.36;
    double heightFactor = (size.height > 700) ? 0.3 : 0.26;
    return Stack(children: [
      Positioned(
        top: (size.height > 700) ? size.height * 0.13 : size.height * 0.1,
        left: (size.height > 700) ? size.width * 0.2 : size.width * 0.26,
        child: IdeaContainerWidget(
          text:
              '¿Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequu?',
          width: size.width * widthFactor,
          height: size.height * heightFactor,
        ),
      ),
      Positioned(
        top: (size.height > 700) ? size.height * 0.28 : size.height * 0.25,
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
        top: size.height * 0.23,
        left: size.width * 0.6,
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

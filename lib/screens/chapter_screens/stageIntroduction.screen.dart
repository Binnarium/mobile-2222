import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageArgumentation.screen.dart';
import 'package:lab_movil_2222/shared/models/ChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageIntroductionScreen extends StatelessWidget {
  static const String route = '/introduction';
  final ChapterSettings chapterSettings;

  const StageIntroductionScreen({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StageArgumentationScreen(
          chapterSettings: this.chapterSettings,
        );
      }));
    };

    final size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          /// left
          if (details.delta.dx > 5) prevPage();

          /// right
          if (details.delta.dx < -5) nextPage();
        },
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: Color(int.parse(chapterSettings.primaryColor)),
              reliefPosition: 'bottom-right',
            ),
            _routeCurve(),
            _stageBody(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  _routeCurve() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/white_route_curve_background.png',
        ),
        color: Color.fromRGBO(255, 255, 255, 100),
      ),
    );
  }

  ///scroll-able content
  _stageBody(Size size) {
    double bodyContainerWidth = size.height * 0.48;
    double bodyContainerHeight = size.height * 0.75;
    double bodyMarginLeft = size.width * 0.10;
    double firstImageContainerWidth = bodyContainerWidth * 0.3;
    double firstImageContainerHeight = bodyContainerHeight * 0.12;
    double firstImageMarginRight = bodyContainerWidth * 0.55;
    double spacedBodyContainers = bodyContainerHeight * 0.015;
    double secondImageContainerWidth = bodyContainerWidth * 0.55;
    double secondImageContainerHeight = bodyContainerHeight * 0.20;
    double secondImageMarginRight = bodyContainerWidth * 0.35;
    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: double.infinity,
      child: ListView(
        children: <Widget>[
          ChapterHeadWidget(
            phaseName: this.chapterSettings.phaseName,
            chapterName: this.chapterSettings.cityName,
            chapterImgURL: this.chapterSettings.chapterImageUrl,
          ),
          Container(
            width: firstImageContainerWidth,
            height: firstImageContainerHeight,
            margin: EdgeInsets.only(right: firstImageMarginRight),
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.white)
            // ),
            child: Image(
              image: AssetImage(
                'assets/backgrounds/decorations/logo_stage_prin.png',
              ),
            ),
          ),
          SizedBox(height: spacedBodyContainers),
          Container(
              width: bodyContainerWidth * 0.9,
              // height: firstImageContainerHeight,
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              child: Text(
                'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium dolo remque laudantium, totam rem aperiam',
                style: korolevFont.headline4
                    ?.apply(fontSizeFactor: 0.45, fontWeightDelta: 2),
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers * 4),
          Container(
              width: bodyContainerWidth * 0.9,
              height: bodyContainerHeight * 0.3,
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              child: Text(
                'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione',
                style: korolevFont.bodyText1,
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers * 4),
          Container(
            width: secondImageContainerWidth,
            height: secondImageContainerHeight,

            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.white)
            // ),
            margin: EdgeInsets.only(right: secondImageMarginRight),
            child: Image(
              image: AssetImage(
                'assets/backgrounds/decorations/logo_stage_secun.png',
              ),
            ),
          ),
          SizedBox(height: spacedBodyContainers * 2),
          Container(
              width: bodyContainerWidth * 0.9,
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              child: Text(
                'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora',
                style: korolevFont.bodyText1,
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers * 4),
        ],
      ),
    );
  }
}

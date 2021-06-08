import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageArgumentation.screen.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageIntroductionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    print(size);
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 5) {
            Navigator.pop(context);
          }
          if (details.delta.dx < -5) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return StageArgumentationScreen();
            }));
          }
        },
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: ColorsApp.backgroundOrange,
              relieve: _backgroundDecoration(),
              hasBanner: true,
            ),
            _routeCurve(),
            _stageBody(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  _backgroundDecoration() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: double.infinity,
      height: double.infinity,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/background_decoration1.png',
        ),
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
    double bodyMarginTop = size.width * 0.30;
    double firstImageContainerWidth = bodyContainerWidth * 0.3;
    double firstImageContainerHeight = bodyContainerHeight * 0.12;
    double firstImageMarginRight = bodyContainerWidth * 0.55;
    double spacedBodyContainers = bodyContainerHeight * 0.015;
    double secondImageContainerWidth = bodyContainerWidth * 0.55;
    double secondImageContainerHeight = bodyContainerHeight * 0.20;
    double secondImageMarginRight = bodyContainerWidth * 0.35;
    return Container(
      alignment: Alignment.topLeft,
      width: bodyContainerWidth,
      height: bodyContainerHeight,
      margin: EdgeInsets.only(
          left: bodyMarginLeft, right: bodyMarginLeft, top: bodyMarginTop),
      // decoration: BoxDecoration(
      //   border: Border.all(color: Colors.blueAccent)
      // ),
      child: ListView(
        children: <Widget>[
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
              height: firstImageContainerHeight,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              child: Text(
                'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium dolo remque laudantium, totam rem aperiam',
                style: korolevFont.headline4?.apply(
                    fontSizeFactor: size.height * 0.00068, fontWeightDelta: 2),
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers),
          Container(
              width: bodyContainerWidth * 0.9,
              height: bodyContainerHeight * 0.3,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              child: Text(
                'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione',
                style: korolevFont.bodyText1?.apply(
                    fontSizeFactor: size.height * 0.0012, fontWeightDelta: 0),
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers),
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
          SizedBox(height: spacedBodyContainers),
          Container(
              width: bodyContainerWidth * 0.9,
              height: bodyContainerHeight * 0.18,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              child: Text(
                'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora',
                style: korolevFont.bodyText2?.apply(
                    fontSizeFactor: size.height * 0.0012, fontWeightDelta: 0),
                textAlign: TextAlign.left,
              ))
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageObjetivesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          if (details.delta.dx > 5) {
            Navigator.pop(context);
          }
          if (details.delta.dx < -5) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return ResourcesScreen();
                },
              ),
            );
          }
        },
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: ColorsApp.backgroundOrange,
              reliefPosition: 'top-left',
              hasBanner: true,
            ),
            _stageBody(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

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
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.only(top: bodyMarginTop),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: ListView(
        children: <Widget>[
          SizedBox(height: spacedBodyContainers),
          Container(
              width: bodyContainerWidth * 0.9,
              height: firstImageContainerHeight,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Text(
                'objetivo',
                style: korolevFont.headline4?.apply(
                    fontSizeFactor: size.height * 0.00068, fontWeightDelta: 2),
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers),
          Container(
              width: double.infinity,
              height: bodyContainerHeight * 0.3,
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Text(
                'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora',
                style: korolevFont.bodyText1?.apply(
                    fontSizeFactor: size.height * 0.0012, fontWeightDelta: 0),
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers),
          Container(
              width: bodyContainerWidth * 0.9,
              height: firstImageContainerHeight,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Text(
                'contenidos',
                style: korolevFont.headline4?.apply(
                    fontSizeFactor: size.height * 0.00068, fontWeightDelta: 2),
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers),
          Container(
              width: double.infinity,
              height: bodyContainerHeight * 0.3,
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Text(
                '',
                style: korolevFont.bodyText1?.apply(
                    fontSizeFactor: size.height * 0.0012, fontWeightDelta: 0),
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers),
          Container(
              width: bodyContainerWidth * 0.9,
              height: firstImageContainerHeight,
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
              child: Text(
                'competencias',
                style: korolevFont.headline4?.apply(
                    fontSizeFactor: size.height * 0.00068, fontWeightDelta: 2),
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers),
          Container(
            width: double.infinity,
            height: bodyContainerHeight * 0.3,
            margin:
                EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: GridView(
              scrollDirection: Axis.horizontal,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
              ),
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.white)
                  // ),

                  child: Image(
                    image: AssetImage(
                      'assets/backgrounds/decorations/competencias1_stage.png',
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.white)
                  // ),

                  child: Image(
                    image: AssetImage(
                      'assets/backgrounds/decorations/competencias2_stage.png',
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  // decoration: BoxDecoration(
                  //   border: Border.all(color: Colors.white)
                  // ),

                  child: Image(
                    image: AssetImage(
                      'assets/backgrounds/decorations/competencia3_stage.png',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

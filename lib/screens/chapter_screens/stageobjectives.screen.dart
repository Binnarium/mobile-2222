import 'package:flutter/material.dart';

import 'package:lab_movil_2222/screens/chapter_screens/stageVideo.screen.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
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
                  return StageVideoScreen();
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
            ),
            _stageBody(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  _stageBody(Size size) {
    double bodyContainerHeight = size.height * 0.75;
    double bodyMarginLeft = size.width * 0.10;
    double bodyMarginTop = size.width * 0.30;

    double spacedBodyContainers = bodyContainerHeight * 0.015;

    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.only(top: bodyMarginTop),
      child: ListView(
        children: <Widget>[
          ChapterHeadWidget(phaseName: 'etapa 4', chapterName: 'aztlán'),
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'OBJETIVO',
          ),
          SizedBox(height: spacedBodyContainers),
          Container(
              width: double.infinity,
              height: bodyContainerHeight * 0.3,
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora',
                style: korolevFont.bodyText1?.apply(
                    fontSizeFactor: size.height * 0.0012, fontWeightDelta: 0),
                textAlign: TextAlign.left,
              )),
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'CONTENIDOS',
          ),
          SizedBox(height: spacedBodyContainers),
          Container(
              width: double.infinity,
              height: bodyContainerHeight * 0.30,
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: _contentsBody([5, 4, 4, 4, 4, 5], size)),
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'COMPETENCIAS',
          ),
          SizedBox(height: spacedBodyContainers + 10),
          Container(
              width: double.infinity,
              height: bodyContainerHeight * 0.18,
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: _compeBody(size)),
          SizedBox(height: spacedBodyContainers + 20),
          Container(
            width: double.infinity,
            height: bodyContainerHeight * 0.40,
            child: Image(
              image: AssetImage(
                'assets/backgrounds/decorations/white_idea_container.png',
              ),
            ),
          ),
          SizedBox(height: spacedBodyContainers + 20),
        ],
      ),
    );
  }

  _contentsBody(List list, Size size) {
    double bodyContainerHeight = size.height * 0.75;

    ///main container
    return Container(
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,

      ///general left padding 25

      ///To resize the parent container of the list of books

      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            ///bringing a book resource per item in the list
            return Row(
              children: [
                Container(
                    width: bodyContainerHeight * 0.1,
                    height: bodyContainerHeight * 0.1,
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: korolevFont.headline2?.apply(
                          fontSizeFactor: size.height * 0.0012,
                          fontWeightDelta: 3),
                      textAlign: TextAlign.center,
                    )),
                Container(
                    width: bodyContainerHeight * 0.40,
                    height: bodyContainerHeight * 0.1,

                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.white)),
                    child: Text(
                      'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia conse',
                      style: korolevFont.bodyText1?.apply(
                          fontSizeFactor: size.height * 0.0012,
                          fontWeightDelta: 0),
                      textAlign: TextAlign.left,
                    )),
              ],
            );
          }),
    );
  }

  _compeBody(Size size) {
    return GridView(
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

          child: Column(
            children: [
              Image(
                image: AssetImage(
                  'assets/backgrounds/decorations/competencias1_stage.png',
                ),
              ),
              Text(
                'MANEJO DEL TIEMPO',
                style: korolevFont.bodyText1?.apply(
                    fontSizeFactor: size.height * 0.0012, fontWeightDelta: 0),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.white)
          // ),

          child: Column(
            children: [
              Image(
                image: AssetImage(
                  'assets/backgrounds/decorations/competencias2_stage.png',
                ),
              ),
              Text(
                'TRABAJO EN EQUIPO',
                style: korolevFont.bodyText1?.apply(
                    fontSizeFactor: size.height * 0.0012, fontWeightDelta: 0),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: double.infinity,
          // decoration: BoxDecoration(
          //   border: Border.all(color: Colors.white)
          // ),

          child: Column(
            children: [
              Image(
                image: AssetImage(
                  'assets/backgrounds/decorations/competencia3_stage.png',
                ),
              ),
              Text(
                'INNOVACIÓN Y CREATIVIDAD',
                style: korolevFont.bodyText1?.apply(
                    fontSizeFactor: size.height * 0.0012, fontWeightDelta: 0),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ],
    );
  }
}

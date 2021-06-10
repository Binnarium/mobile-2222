import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
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

    double firstImageContainerHeight = bodyContainerHeight * 0.12;

    double spacedBodyContainers = bodyContainerHeight * 0.015;

    return Container(
      alignment: Alignment.topLeft,
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.only(top: bodyMarginTop),
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      child: ListView(
        children: <Widget>[
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
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.white)),
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
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
            child: _contentsBody([5, 4, 4, 4, 4, 5])
          ),
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'COMPETENCIAS',
          ),
          SizedBox(height: spacedBodyContainers),
          Container(
            width: double.infinity,
            height: bodyContainerHeight * 0.18,
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

  _contentsBody(List list) {
    ///main container
    return Container(
      height: double.infinity,
      width: double.infinity,
      ///general left padding 25
      
      decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),

      ///To resize the parent container of the list of books
      
      child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            ///bringing a book resource per item in the list
            return Container(
              padding: EdgeInsets.all(15),
              child: Row(
                children: [
                  Text('${index+1}',
                  textAlign: TextAlign.left,),
                  Text(
                      'Contenido')
                ],
              ),
            );
          }),
    );
  }
}

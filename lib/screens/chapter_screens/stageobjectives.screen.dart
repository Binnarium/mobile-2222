import 'package:flutter/material.dart';

import 'package:lab_movil_2222/screens/chapter_screens/stageVideo.screen.dart';
import 'package:lab_movil_2222/shared/models/ChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/compe-resources-list-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class StageObjetivesScreen extends StatelessWidget {
  static const String route = '/argumentation';
  final ChapterSettings chapterSettings;

  const StageObjetivesScreen({Key? key, required this.chapterSettings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return StageVideoScreen(
          chapterSettings: this.chapterSettings,
        );
      }));
    };

    final size = MediaQuery.of(context).size;
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
              reliefPosition: 'top-left',
            ),
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

  _stageBody(Size size) {
    double bodyContainerHeight = size.height * 0.75;

    double spacedBodyContainers = bodyContainerHeight * 0.035;

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
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'OBJETIVO',
          ),
          SizedBox(height: spacedBodyContainers),
          _objetBody(size),
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'CONTENIDOS',
          ),
          SizedBox(height: spacedBodyContainers),
          _contentsBody([4, 4, 5], size),
          SizedBox(height: spacedBodyContainers),
          ChapterTitleSection(
            title: 'COMPETENCIAS',
          ),
          SizedBox(height: spacedBodyContainers + 10),
          _compeBody([4, 4, 4], size),
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

  _objetBody(Size size) {
    String texto =
        'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora';
    double bodyMarginLeft = size.width * 0.10;
    return Container(
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      margin: EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
      child: Text(
        texto,
        style: korolevFont.bodyText1,
        textAlign: TextAlign.left,
      ),
    );
  }

  _contentsBody(List list, Size size) {
    double bodyContainerHeight = size.height * 0.75;
    double bodyContainerWidth = size.width * 0.75;

    ///main container
    return Container(
      ///general left padding 25
      padding: EdgeInsets.only(left: 25),

      ///To resize the parent container of the list of books
      height: (list.length) * bodyContainerHeight * 0.125,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            ///bringing a book resource per item in the list
            return Row(
              children: [
                Container(
                    width: bodyContainerWidth * 0.1,
                    height: bodyContainerHeight * 0.1,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    alignment: Alignment.center,
                    child: Text(
                      '${index + 1}',
                      style: korolevFont.headline3?.apply(fontWeightDelta: 1),
                      textAlign: TextAlign.center,
                    )),
                SizedBox(
                  width: 10,
                ),
                Container(
                    width: bodyContainerWidth,
                    height: bodyContainerHeight * 0.1,
                    margin: EdgeInsets.symmetric(vertical: 5),
                    // decoration:
                    //     BoxDecoration(border: Border.all(color: Colors.white)),
                    child: Text(
                      'Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia conse',
                      style: korolevFont.bodyText1?.apply(fontSizeFactor: 0.9),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                    )),
              ],
            );
          }),
    );
  }

  _compeBody(List list, Size size) {
    return Container(
      ///To resize the parent container of the online resources grid
      height: (list.length) * 55,
      width: (list.length) * 75,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: (size.height > 700)
            ? EdgeInsets.only(left: 60)
            : EdgeInsets.only(left: 30),

        ///general spacing per resource
        itemCount: list.length,

        ///to avoid the scroll
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          ///calls the custom widget with the item parameters
          return CompeResourcesListItem(
              image: 'competencias${index + 1}_stage',
              description: 'MANEJO\n DEL TIEMPO');
        },
      ),
    );
  }
}

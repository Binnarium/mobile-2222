import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/models/ChapterSettings.model.dart';

import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-subtitle-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/club-resources-grid-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ChapterClubhouseScreen extends StatelessWidget {
  static const String route = '/chapterClubhouse';
  final ChapterSettings chapterSettings;

  const ChapterClubhouseScreen({Key? key, required this.chapterSettings})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          ///To make the horizontal scroll to the next or previous page.
          onPanUpdate: (details) {
            /// left
            if (details.delta.dx > 5) prevPage();
          },
          child: Stack(
            children: [
              ChapterBackgroundWidget(
                backgroundColor: Color(int.parse(chapterSettings.primaryColor)),
                reliefPosition: 'bottom-right',
              ),

              ///body of the screen
              _resourcesContent(size),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        prevPage: prevPage,
      ),
    );
  }

  ///body of the screen
  _resourcesContent(Size size) {
    double bodyContainerHeight = size.height * 0.75;
    double bodyMarginLeft = size.width * 0.10;
    double fontSize = (size.height > 600) ? 0.97 : 0.8;

    ///sizing the container to the mobile
    return Container(
      ///Listview of the whole screen
      child: ListView(
        children: [
          ChapterHeadWidget(
            phaseName: this.chapterSettings.phaseName,
            chapterName: this.chapterSettings.cityName,
            chapterImgURL: this.chapterSettings.chapterImageUrl,
          ),
          SizedBox(
            height: 50,
          ),
          Container(
              width: double.infinity,
              height: bodyContainerHeight * 0.12,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              // margin:
              //     EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                'CLUBHOUSE',
                style: korolevFont.headline2?.apply(fontSizeFactor: fontSize),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              width: double.infinity,
              height: bodyContainerHeight * 0.13,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                'Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto.',
                style: korolevFont.bodyText1?.apply(fontSizeFactor: fontSize),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center,
              )),

          SizedBox(
            height: 20,
          ),
          ChapterSubtitleSection(
            title: 'PRÓXIMOS ENCUENTROS',
          ),
          SizedBox(
            height: 35,
          ),

          ///calling the body of online resources, expected a json
          _onlineResourcesBody([
            2,
            3,
            2,
            1,
            2,
          ]),
        ],
      ),
    );
  }

  ///books body method

  ///Method of the online resources
  _onlineResourcesBody(List list) {
    ///main container
    return Container(
      ///To resize the parent container of the online resources grid
      height: (list.length) * 110,

      ///Creates a grid with the necesary online resources
      child: GridView.builder(
        ///general spacing per resource
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 5),
        itemCount: list.length,

        ///to avoid the scroll
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          ///calls the custom widget with the item parameters
          return ClubResourcesGridItem(
              theme: 'TEMA DEL ENCUENTRO',
              schedule: 'LUNES 12/06 // 13:30 HS.',
              agenda: 'AÑADIR A MI AGENDA');
        },
      ),
    );
  }
}

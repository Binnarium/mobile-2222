import 'package:flutter/material.dart';

import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-subtitle-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/club-resources-grid-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/lectures-list-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/online-resources-grid-item_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ClubScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          ///To make the horizontal scroll to the next or previous page.
          onPanUpdate: (details) {
            ///left
            if (details.delta.dx > 5) {
              Navigator.pop(context);
            }

            ///right
            if (details.delta.dx < -5) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ClubScreen();
                  },
                ),
              );
            }
          },
          child: Stack(
            children: [
              ChapterBackgroundWidget(
                backgroundColor: ColorsApp.backgroundOrange,
                reliefPosition: 'bottom-right',
              ),

              ///body of the screen
              _resourcesContent(size),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  ///body of the screen
  _resourcesContent(Size size) {
    double bodyMarginWidth = size.width * 0.03;
    double bodyContainerHeight = size.height * 0.75;
    double bodyMarginLeft = size.width * 0.10;

    ///sizing the container to the mobile
    return Container(
      margin: EdgeInsets.only(
        right: bodyMarginWidth,
      ),

      ///Listview of the whole screen
      child: ListView(
        children: [
          ChapterHeadWidget(phaseName: 'etapa 4', chapterName: 'aztlán'),
          SizedBox(
            height: 50,
          ),
          Container(
              width: double.infinity,
              height: bodyContainerHeight * 0.12,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                'CLUBHOUSE',
                style: korolevFont.headline2?.apply(fontSizeFactor: 0.97),
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
                style: korolevFont.bodyText1?.apply(fontSizeFactor: 0.97),
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
      padding: EdgeInsets.only(left: 25),

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
          return ClubResourcesGridItem(theme: 'TEMA DEL ENCUENTRO', schedule: 'LUNES 12/06 // 13:30 HS.',agenda: 'AÑADIR A MI AGENDA');
        },
      ),
    );
  }
}

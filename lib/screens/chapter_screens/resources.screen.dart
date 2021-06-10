import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/lectures-list-item_widget.dart';
import 'package:lab_movil_2222/shared/widgets/online-resources-grid-item_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class ResourcesScreen extends StatelessWidget {
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
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   print('se movió a la derecha');
              //   return StageIntroductionScreen();
              // },),);
            }
          },
          child: Stack(
            children: [
              ChapterBackgroundWidget(
                backgroundColor: ColorsApp.backgroundOrange,
                hasBanner: true,
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
    double bodyMarginHeight = size.height * 0.18;

    ///sizing the container to the mobile
    return Container(
      margin: EdgeInsets.only(
        top: bodyMarginHeight,
        right: bodyMarginWidth,
      ),

      ///Listview of the whole screen
      child: ListView(
        children: [
          ///chapter title screen widgets
          ChapterTitleSection(
            title: 'LECTURAS',
          ),
          SizedBox(
            height: 20,
          ),

          ///list of the bodys (json expected)
          _booksBody([3, 2]),
          ChapterTitleSection(
            title: 'RECURSOS ONLINE',
          ),
          SizedBox(
            height: 20,
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
  _booksBody(List list) {
    ///main container
    return Container(
      ///general left padding 25
      padding: EdgeInsets.only(left: 25),

      ///To resize the parent container of the list of books
      height: (list.length) * 150,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            ///bringing a book resource per item in the list
            return LecturesListItem(
              imageURL:
                  'https://www.pngarts.com/files/8/Blank-Book-Cover-PNG-Picture.png',
              title: 'El Principito valiente',
              author: 'Daniel Novillo',
              year: '1979',
              editorial: 'Editorial San José Ignacio de Barravanes',
              review:
                  'Tenim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia conseunde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam',
            );
          }),
    );
  }

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
            crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
        itemCount: list.length,

        ///to avoid the scroll
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          ///calls the custom widget with the item parameters
          return OnlineResourcesGridItem(
              account: 'Platzi/live',
              type: 'youtube',
              description:
                  'Tenim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit,sed quia conseunde omnis iste natus error sit voluptatem accusantium doloremque');
        },
      ),
    );
  }
}

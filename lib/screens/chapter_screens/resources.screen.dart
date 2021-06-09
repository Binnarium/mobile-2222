import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-title-section.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ResourcesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(size);
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

  _resourcesContent(Size size) {
    double bodyMarginWidth = size.width * 0.30;
    double bodyMarginHeight = size.height * 0.03;
    return Container(
      margin: EdgeInsets.only(
        top: bodyMarginWidth,
        right: bodyMarginHeight,
      ),
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: ListView(
        children: [
          ChapterTitleSection(
            title: 'LECTURAS',
          ),
          SizedBox(
            height: 10,
          ),
          _booksBody([3, 2, 5, 6]),
          ChapterTitleSection(
            title: 'RECURSOS ONLINE',
          ),
          SizedBox(
            height: 10,
          ),
          ChapterTitleSection(
            title: 'Objetivo'.toUpperCase(),
          ),
          SizedBox(
            height: 10,
          ),
          ChapterTitleSection(
            title: 'Contenidos'.toUpperCase(),
          ),
          SizedBox(
            height: 10,
          ),
          ChapterTitleSection(
            title: 'Competencias'.toUpperCase(),
          ),
        ],
      ),
    );
  }

  _booksBody(List list) {
    return Container(
      padding: EdgeInsets.only(left: 25),
      height: list.length * 90,
      child: ListView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: list.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: FadeInImage(
                placeholder: AssetImage('assets/gifs/giphy.gif'),
                image: NetworkImage(
                    'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b4/The_Portrait_of_a_lady_cover.jpg/220px-The_Portrait_of_a_lady_cover.jpg'),
                fit: BoxFit.cover,
              ),
              title: Text(
                'TÍTULO LIBRO',
                style: korolevFont.headline6,
              ),
              subtitle: Text(
                'Autor | Editorial | Año',
                style: korolevFont.bodyText2,
              ),
              isThreeLine: true,
              onTap: () {
                print('presionó');
              },
            );
          }),
    );
  }
}

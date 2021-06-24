import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ProfileScreen extends StatelessWidget {
  static const String route = '/profile';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: ColorsApp.backgroundRed,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen
            _resourcesContent(size),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        activePage: NavigationBarPages.page3,
      ),
    );
  }

  ///body of the screen
  _resourcesContent(Size size) {
    double bodyMarginWidth = size.width * 0.03;
    double bodyContainerHeight = size.height * 0.33;
    double bodyMarginLeft = size.width * 0.10;
    if(size.width>500){
      bodyContainerHeight = size.height * 0.99;
    }

    ///sizing the container to the mobile
    return Container(
      margin: EdgeInsets.only(
        right: bodyMarginWidth,
      ),

      ///Listview of the whole screen
      child: ListView(
        children: [
          ChapterHeadWidget(
            phaseName: 'etapa 4',
            chapterName: 'aztlán',
            chapterImgURL:
                'assets/backgrounds/chapterImages/aztlan_chapter_img.png',
          ),
          SizedBox(
            height: 30,
          ),
          Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                'MI PERFIL',
                style: korolevFont.headline5?.apply(fontSizeFactor: 0.96),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.white)),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                'RODRIGO ZAMORANO',
                style: korolevFont.headline3?.apply(fontSizeFactor: 0.77),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 30,
          ),
          Container(
              width: double.infinity,
              height: bodyContainerHeight*0.35,
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Row(
                children: [
                  Image(
                    image: AssetImage(
                        'assets/backgrounds/decorations/elipse_profile.png'),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Profesor de xxx xxx xxxxx xxx',
                        style:
                            korolevFont.bodyText1?.apply(fontSizeFactor: 0.97),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Otra información secundaria',
                        style:
                            korolevFont.bodyText1?.apply(fontSizeFactor: 0.97),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  )
                ],
              )),
          SizedBox(
            height: 40,
          ),
          Container(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.white)),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                'NIVELES COMPLETADOS',
                style: korolevFont.headline4?.apply(fontSizeFactor: 0.80),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              // decoration:
              //     BoxDecoration(border: Border.all(color: Colors.white)),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                '4',
                style: korolevFont.headline4?.apply(),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: bodyContainerHeight*0.5,
          ),
          Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                'CONSUMO DE CONTENIDOS',
                style: korolevFont.headline4?.apply(fontSizeFactor: 0.80),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                '22%',
                style: korolevFont.headline3
                    ?.apply(fontSizeFactor: 0.80, fontWeightDelta: 2),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 30,
          ),
          Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                'PROXIMA ETAPA',
                style: korolevFont.headline4?.apply(fontSizeFactor: 0.60),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 10,
          ),
          Container(
              // decoration: BoxDecoration(
              //   border: Border.all(color: Colors.white)
              // ),
              margin:
                  EdgeInsets.only(left: bodyMarginLeft, right: bodyMarginLeft),
              child: Text(
                'ATLÁNTIDA',
                style: korolevFont.headline3
                    ?.apply(fontSizeFactor: 0.80, fontWeightDelta: 2),
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }

  ///books body method

  ///Method of the online resources

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
}

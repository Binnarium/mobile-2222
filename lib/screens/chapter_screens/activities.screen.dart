import 'package:flutter/material.dart';
import 'package:lab_movil_2222/shared/widgets/activiy_container_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ActivitiesScreen extends StatelessWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);
  static const Map<String, String> activities = {
    'club-house':
        'Tenim ipsam voluptatem quia voluptas sit aspe natur aut odit aut fugit sed quia',
    'lectures':
        'Tenim ipsam voluptatem quia voluptas sit aspe natur aut odit aut fugit sed quia',
    'mult-choice':
        'Tenim ipsam voluptatem quia voluptas sit aspe natur aut odit aut fugit sed quia',
    'project':
        'Tenim ipsam voluptatem quia voluptas sit aspe natur aut odit aut fugit sed quia',
  };
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
                reliefPosition: 'bottom-right',
              ),

              ///body of the screen
              _activitiesContent(size),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(),
    );
  }

  _activitiesContent(Size size) {
    ///sizing the container to the mobile
    return Container(
      ///Listview of the whole screen
      child: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          ChapterHeadWidget(phaseName: 'etapa 4', chapterName: 'aztlán'),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              'Actividades de aztlán'.toUpperCase(),
              style: korolevFont.headline2?.apply(fontSizeFactor: 0.8),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          _activitiesCircle(size),
        ],
      ),
    );
  }

  _activitiesCircle(Size size) {
    ///margin of the container
    double bodymarginWidth = size.width * 0.03;

    ///0.06 counting the padding
    double containerWidth = size.width - bodymarginWidth * 2;

    ///0.12 is the height of the banner
    double containerHeight = size.height - size.height * 0.4;
    return Container(
      width: containerWidth,
      height: containerHeight,
      margin: EdgeInsets.symmetric(horizontal: bodymarginWidth),
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ///background chapter image
          Image(
            image: AssetImage(
                'assets/backgrounds/decorations/black_icon_container.png'),
            width: containerWidth * 0.5,
            height: containerHeight * 0.5,
          ),
          Image(
            image: AssetImage(
                'assets/backgrounds/decorations/white_route_circle_curve_background.png'),
            width: containerWidth * 0.85,
            height: containerHeight * 0.85,
          ),

          ActivityContainerWidget(
              activities: activities,
              width: containerWidth,
              height: containerHeight)
        ],
      ),
    );
  }
}

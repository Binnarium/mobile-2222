import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/chapterClubhouse.screen.dart';
import 'package:lab_movil_2222/shared/models/ChapterSettings.model.dart';
import 'package:lab_movil_2222/shared/widgets/activiy_container_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ActivitiesScreen extends StatelessWidget {
  static const String route = '/activities';
  final ChapterSettings chapterSettings;

  const ActivitiesScreen({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);

  static const Map<String, String> _activities = {
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
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ChapterClubhouseScreen(
          chapterSettings: this.chapterSettings,
        );
      }));
    };
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: GestureDetector(
          ///To make the horizontal scroll to the next or previous page.
          // onPanUpdate: (details) =>
          //     (details.delta.dx > 5 ? prevPage : nextPage)(),
          onPanUpdate: (details) {
            ///left
            if (details.delta.dx > 5) prevPage();

            ///right
            if (details.delta.dx < -5) nextPage();
          },
          child: Stack(
            children: [
              ChapterBackgroundWidget(
                backgroundColor: Color(int.parse(chapterSettings.primaryColor)),
                reliefPosition: 'bottom-right',
              ),

              ///body of the screen
              _activitiesContent(size),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  _activitiesContent(Size size) {
    /// sizing the container to the mobile
    return Container(
      /// Listview of the whole screen
      child: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          ChapterHeadWidget(
            phaseName: this.chapterSettings.phaseName,
            chapterName: this.chapterSettings.cityName,
            chapterImgURL: this.chapterSettings.chapterImageUrl,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              'Actividades de ${this.chapterSettings.cityName}'.toUpperCase(),
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
      margin: EdgeInsets.symmetric(horizontal: bodymarginWidth),
      // decoration: BoxDecoration(border: Border.all(color: Colors.white)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ///background chapter image
          Image(
            image: AssetImage(this.chapterSettings.chapterImageUrl),
            width: containerWidth * 0.5,
            height: containerHeight * 0.5,
          ),
          Image(
            image: AssetImage(this.chapterSettings.decoration1Url),
            width: containerWidth * 0.85,
            height: containerHeight * 0.85,
            color: Color.fromRGBO(255, 255, 255, 0.5),
          ),

          ActivityContainerWidget(
            activities: _activities,
            width: containerWidth,
            height: containerHeight,
            primaryColor: this.chapterSettings.primaryColor,
          )
        ],
      ),
    );
  }
}

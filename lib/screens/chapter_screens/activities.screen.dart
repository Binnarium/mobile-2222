import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/chapterClubhouse.screen.dart';
import 'package:lab_movil_2222/shared/widgets/activiy_container_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ActivitiesScreen extends StatelessWidget {
  static const String route = '/activities';
  final CityDto chapterSettings;

  const ActivitiesScreen({
    Key? key,
    required this.chapterSettings,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () {
      Navigator.pushNamed(
        context,
        ChapterClubhouseScreen.route,
        arguments: ChapterClubhouseScreen(
          chapterSettings: this.chapterSettings,
        ),
      );
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
                backgroundColor: Color(chapterSettings.configuration.colorHex),
                reliefPosition: 'bottom-right',
              ),

              ///body of the screen
              _activitiesContent(context, size),
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

  _activitiesContent(BuildContext context, Size size) {
    /// sizing the container to the mobile
    return Container(
      /// Listview of the whole screen
      child: ListView(
        // physics: NeverScrollableScrollPhysics(),
        children: [
          SizedBox(
            height: 10,
          ),
          ChapterHeadWidget(
            showStageLogo: true,
            city: this.chapterSettings,
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Text(
              'Actividades'.toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .apply(fontSizeFactor: 0.8),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          // _activitiesCircle(size),
          _activitiesBody(size),
        ],
      ),
    );
  }

  _activitiesBody(Size size) {
    return ActivitiesWidget(chapterSettings: chapterSettings);
  }
}

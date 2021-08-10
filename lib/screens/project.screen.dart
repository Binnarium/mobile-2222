import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/podcast_audioPlayer_widget.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

import 'chapter_screens/stageIntroduction.screen.dart';

class ProjectScreen extends StatefulWidget {
  static const String route = '/project';
  final CityDto chapterSettings;

  const ProjectScreen({Key? key, required this.chapterSettings})
      : super(key: key);
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  late List<CityDto> chapters;
  @override
  void initState() {
    super.initState();
    ILoadInformationService<List<CityDto>> loader = LoadCitiesSettingService();
    loader.load().then((value) => this.setState(() => this.chapters = value));
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);

    VoidCallback? nextPage = this.widget.chapterSettings.stage == 12
        ? null
        : () => Navigator.pushNamed(
              context,
              StageIntroductionScreen.route,
              arguments: StageIntroductionScreen(
                city: chapters[this.widget.chapterSettings.stage],
              ),
            );

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: GestureDetector(
        ///To make the horizontal scroll to the next or previous page.
        onPanUpdate: (details) {
          /// left
          if (details.delta.dx > 5) prevPage();

          /// right
          if (details.delta.dx < -5 && nextPage != null) nextPage();
        },
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: this.widget.chapterSettings.color,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen

            _projectSheet(context, size, this.widget.chapterSettings.color)
          ],
        ),
      )),
      bottomNavigationBar: CustomNavigationBar(
        prevPage: prevPage,
        nextPage: nextPage,
      ),
    );
  }

  _routeCurve() {
    return Container(
      alignment: Alignment.bottomCenter,
      child: Image(
        image: AssetImage(
          'assets/backgrounds/decorations/white_route_curve_background.png',
        ),
        color: Colors.white.withOpacity(0.25),
      ),
    );
  }

  _projectSheet(BuildContext context, Size size, Color color) {
    return Container(
        
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
              child: Column(
                children: [
            SizedBox(
              height: 50,
            ),
            Text(
              "PROYECTO PERSONAL DE",
              style: korolevFont.headline5?.apply(
                fontSizeFactor: 1.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "INNOVACIÓN DOCENTE",
              style: korolevFont.headline6?.apply(
                fontSizeFactor: 1.7,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(right: 50),
              child: Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nec tortor vestibulum, volutpat erat laoreet, feugiat mi. Nam hendrerit, massa id accumsan molestie, est magna ornare ipsum, eget interdum feli",
                style: korolevFont.bodyText1?.apply(
                  fontSizeFactor: 0.95,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 90,
            ),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam nec tortor vestibulum, volutpat erat laoreet, feugiat mi. Nam hendrerit, massa id accumsan molestie, est magna ornare ipsum, eget interdum felis eros at tellus. Nam et nisi non ligula maximus convallis. Suspendisse in pharetra elit, eu tempor urna. Aenean sit amet tempus dui. Suspendisse molestie risus a ipsum laoreet finibus. Phasellus mi metus, vestibulum et lobortis a, aliquam ac odio. Fusce interdum id neque ut fermentum. Curabitur pellentesque sem elit, ut ultricies massa rutrum quis. Sed commodo tempus pharetra.",
              style: korolevFont.bodyText2?.apply(
                fontSizeFactor: 0.95,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
                ],
              )
            ),
            
            Container(
              alignment: Alignment.center,
              child: PodcastAudioPlayer(
                audioUrl: "",
                description: "",
                color: this.widget.chapterSettings.color,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            _taskButton(context, color)
          ],
        ));
  }
}

_taskButton(BuildContext context, color) {
  double buttonWidth = MediaQuery.of(context).size.width;
  return Container(
    width: buttonWidth,
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 5,
      ),

      ///Navigates to main screen
      onPressed: () {},
      child: Text(
        'Subir Tarea',
        style: korolevFont.headline6?.apply(color: color),
      ),
    ),
  );
}

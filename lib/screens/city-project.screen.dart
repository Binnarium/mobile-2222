import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/project.model.dart';
import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/services/load-project-activity.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/podcast_audioPlayer_widget.dart';

import 'chapter_screens/stageIntroduction.screen.dart';

class CityProjectScreen extends StatefulWidget {
  static const String route = '/project';

  final CityDto city;

  final ILoadInformationWithOptions<ProjectDto, CityDto> projectLoader;

  CityProjectScreen({
    Key? key,
    required this.city,
  })  : this.projectLoader = LoadProject(city: city),
        super(key: key);

  @override
  _CityProjectScreenState createState() => _CityProjectScreenState();
}

class _CityProjectScreenState extends State<CityProjectScreen> {
  late List<CityDto> chapters;

  ProjectDto? project;

  @override
  void initState() {
    super.initState();

    /// called service to load the next chapter
    ILoadInformationService<List<CityDto>> loader = LoadCitiesSettingService();
    loader.load().then((value) => this.setState(() => this.chapters = value));
    print('called');
    this
        .widget
        .projectLoader
        .load()
        .then((value) => this.setState(() => this.project = value));
  }

  @override
  Widget build(BuildContext context) {
    VoidCallback prevPage = () => Navigator.pop(context);

    VoidCallback? nextPage = this.widget.city.stage == 12
        ? null
        : () => Navigator.pushNamed(
              context,
              StageIntroductionScreen.route,
              arguments: StageIntroductionScreen(
                /// will go to the next chapter
                city: chapters[this.widget.city.stage],
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
              backgroundColor: this.widget.city.color,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen

            _projectSheet(context, size, this.widget.city.color)
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
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1, vertical: 50),
      children: [
        Center(
          child: Text(
            "PROYECTO PERSONAL",
            style: textTheme.headline4,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            "DE INNOVACIÓN DOCENTE",
            style: textTheme.headline5,
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        if (this.project == null)
          AppLoading()
        else ...[
          Container(
            padding: EdgeInsets.only(right: 50),
            child: Text(
              this.project!.activity,
              style: textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: 90,
          ),
          MarkdownBody(
            data: this.project!.explanation,
            styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
              textAlign: WrapAlignment.center,
            ),
          ),

          SizedBox(
            height: 20,
          ),

          /// if audio is available then show the audio player
          if (this.project!.audio != null) ...[
            Container(
              alignment: Alignment.center,
              child: PodcastAudioPlayer(
                audioUrl: this.project!.audio!.url,
                description: "",
                color: this.widget.city.color,
              ),
            ),
            SizedBox(
              height: 60,
            ),
          ],
          _taskButton(context, color)
        ],
      ],
    );
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
      ),
    ),
  );
}

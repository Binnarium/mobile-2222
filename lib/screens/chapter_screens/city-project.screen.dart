import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/project.model.dart';
import 'package:lab_movil_2222/providers/audioPlayer_provider.dart';
import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/services/load-project-activity.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/podcast_audioPlayer_widget.dart';
import 'package:lab_movil_2222/shared/widgets/scaffold-2222.widget.dart';

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

  AudioPlayerProvider audioProvider = AudioPlayerProvider();

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
    Size size = MediaQuery.of(context).size;
    return Scaffold2222(
      city: this.widget.city,
      backgrounds: [
        BackgroundDecoration.bottomRight,
        BackgroundDecoration.path
      ],
      route: CityProjectScreen.route,
      body: _projectSheet(context, size, this.widget.city.color),
    );
  }

  _projectSheet(BuildContext context, Size size, Color color) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 50),
      children: [
        Text(
          "PROYECTO PERSONAL DE INNOVACIÓN DOCENTE",
          style: textTheme.headline5,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 16,
        ),
        if (this.project == null)
          AppLoading()
        else ...[
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth * 0.7,
              padding: EdgeInsets.only(bottom: 16),
              child: Stack(
                children: [
                  /// text
                  Container(
                    padding: EdgeInsets.only(
                      top: 16,
                      bottom: 80,
                      right: constraints.maxWidth * 0.35,
                      left: constraints.maxWidth * 0.05,
                    ),
                    child: Text(
                      this.project!.activity,
                      style: textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  /// path background
                  Positioned.fill(
                    child: LayoutBuilder(
                      builder: (context, constraints) => Image.asset(
                        'assets/images/path-project.png',
                        alignment: Alignment.bottomRight,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
                audio: this.project!.audio!,
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

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/player-projects.dto.dart';
import 'package:lab_movil_2222/models/project.model.dart';
import 'package:lab_movil_2222/providers/audioPlayer_provider.dart';
import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';
import 'package:lab_movil_2222/services/load-project-activity.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/podcast_audioPlayer_widget.dart';
import 'package:lab_movil_2222/shared/widgets/project-gallery.widget.dart';
import 'package:lab_movil_2222/shared/widgets/upload-file-dialog.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

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
  List<PlayerProject>? playerProjects = [];
  ProjectDto? project;
  String? userUID;
  @override
  void initState() {
    super.initState();

    /// called service to load the next chapter
    ILoadInformationService<List<CityDto>> loader = LoadCitiesSettingService();
    loader.load().then((value) => this.setState(() => this.chapters = value));

    this
        .widget
        .projectLoader
        .load()
        .then((value) => this.setState(() => this.project = value));
    loadPlayerProjects();
  }

  /// to load the projects of the player and set to this screen
  void loadPlayerProjects() async {
    this.userUID = FirebaseAuth.instance.currentUser!.uid;
    LoadPlayerInformationService playerLoader = LoadPlayerInformationService();
    await playerLoader
        .loadProjects(this.userUID!)
        .then((value) => this.setState(() {
              this.playerProjects = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold2222(
      city: this.widget.city,
      backgrounds: [
        BackgroundDecorationStyle.bottomRight,
        BackgroundDecorationStyle.path
      ],
      route: CityProjectScreen.route,
      body: _projectSheet(context, size, this.widget.city.color, userUID!,
          this.playerProjects!),
    );
  }

  _projectSheet(BuildContext context, Size size, Color color, String userUID,
      List<PlayerProject> playerProjects) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    setState(() {});
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
              height: 40,
            ),
            ProjectGalleryWidget(
                city: this.widget.city,
                userUID: userUID,
                projects: playerProjects),
          ],

          _taskButton(
            context,
            color,
            this.widget.city.name,
          )
        ],
      ],
    );
  }
}

_taskButton(BuildContext context, color, String cityName) {
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
      onPressed: () async {
        return await showDialog(
            context: context,
            builder: (context) {
              /// creates the alert dialog to upload file
              return UploadFileDialog(
                cityName: cityName,
                color: color,
              );
            });
      },
      child: Text(
        'Subir Proyecto',
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors2222.black),
      ),
    ),
  );
}


import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-player.widget.dart';
import 'package:lab_movil_2222/cities/project/models/player-projects.model.dart';
import 'package:lab_movil_2222/cities/project/services/load-project-files.service.dart';
import 'package:lab_movil_2222/cities/project/services/upload-file.service.dart';
import 'package:lab_movil_2222/cities/project/services/upload-project.service.dart';
import 'package:lab_movil_2222/city/services/cities.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/project.model.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:lab_movil_2222/services/load-project-activity.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/project-gallery.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class CityProjectScreen extends StatefulWidget {
  static const String route = '/project';

  final CityModel city;

  CityProjectScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  @override
  _CityProjectScreenState createState() => _CityProjectScreenState();
}

class _CityProjectScreenState extends State<CityProjectScreen> {
  List<PlayerProject>? playerProjects = [];
  ProjectDto? project;

  StreamSubscription? _userProjectsSub;
  StreamSubscription? _loadProjectDtoSub;
  String? userUID;

  @override
  void initState() {
    super.initState();

    userUID = FirebaseAuth.instance.currentUser!.uid;

    /// called service to load the next chapter
   CitiesService loader = CitiesService();

    /// load the provider to load the projectDTO
    LoadProjectDtoService loadProjectDtoService =
        Provider.of<LoadProjectDtoService>(this.context, listen: false);

    /// calls the service to load the projectDTO
    this._loadProjectDtoSub =
        loadProjectDtoService.load$(this.widget.city).listen(
      (projectDto) {
        if (this.mounted)
          this.setState(() {
            this.project = projectDto;
          });
      },
    );

    /// stream of projects
    LoadProjectFiles loadProjectFiles =
        Provider.of<LoadProjectFiles>(context, listen: false);
    this._userProjectsSub = loadProjectFiles.load$(this.widget.city).listen(
      (projects) {
        if (this.mounted)
          this.setState(() {
            this.playerProjects = projects;
          });
      },
    );
  }

  @override
  void dispose() {
    _userProjectsSub?.cancel();
    _loadProjectDtoSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [
        BackgroundDecorationStyle.topRight,
        BackgroundDecorationStyle.path
      ],
      route: CityProjectScreen.route,
      body: _projectSheet(
          context, size, this.widget.city.color, userUID, this.playerProjects),
    );
  }

  _projectSheet(BuildContext context, Size size, Color color, String? userUID,
      List<PlayerProject>? playerProjects) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final horizontalPadding =
        EdgeInsets.symmetric(horizontal: size.width * 0.08);
    return ListView(
      children: [
        /// icon item
        Padding(
          padding: EdgeInsets.only(
            bottom: 32.0,
          ),
          child: LogosHeader(
            showStageLogoCity: this.widget.city,
          ),
        ),

        Center(
          child: Container(
            width: min(300, size.width * 0.9),
            child: Text(
              "PROYECTO DOCENTE".toUpperCase(),
              style: textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),
        ),

        ///
        SizedBox(
          height: 24,
        ),

        Center(
          child: Image(
            image: CoinsImages.project(),
            alignment: Alignment.bottomRight,
            fit: BoxFit.contain,
            width: min(160, size.width * 0.4),
          ),
        ),

        ///
        SizedBox(
          height: 32,
        ),

        ///
        if (this.project == null)
          AppLoading()
        else ...[
          Padding(
            padding: horizontalPadding,
            child: Text(
              this.project!.activity,
              style: textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          SizedBox(
            height: 28,
          ),

          ///
          Padding(
            padding: horizontalPadding,
            child: Markdown2222(
              data: this.project!.explanation,
              contentAlignment: WrapAlignment.start,
            ),
          ),

          SizedBox(
            height: 20,
          ),

          /// if audio is available then show the audio player
          if (this.project!.audio != null) ...[
            Container(
              alignment: Alignment.center,
              padding: horizontalPadding,
              child: AudioPlayerWidget(
                audio: this.project!.audio!,
                color: this.widget.city.color,
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],

          /// upload files
          if (this.project!.allowFile || this.project!.allowAudio) ...[
            Padding(
              padding: horizontalPadding,
              child: ProjectGalleryWidget(
                  city: this.widget.city,
                  userUID: userUID ?? '',
                  projects: playerProjects!),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 50),
              child: _taskButton(
                context,
                color,
                this.widget.city,
              ),
            )
          ],
        ],
      ],
    );
  }
}

_taskButton(BuildContext context, color, CityModel city) {
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
                city: city,
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

/// Creates alert dialog to upload file [color] is needed to create the button
/// with the city color
class UploadFileDialog extends StatefulWidget {
  final Color color;
  final CityModel city;

  final UploadProjectService _uploadProjectService;

  UploadFileDialog({
    Key? key,
    required this.color,
    required this.city,
  })  : this._uploadProjectService = UploadProjectService(),
        super(key: key);

  @override
  _UploadFileDialogState createState() => _UploadFileDialogState();
}

class _UploadFileDialogState extends State<UploadFileDialog> {
  StreamSubscription? _userServiceSub;
  StreamSubscription? _uploadFileSub;
  PlayerModel? player;

  @override
  void initState() {
    super.initState();
    this._userServiceSub =
        CurrentPlayerService.instance.player$.listen((event) {
      this.player = event;
      setState(() {});
      print('PLAYER ES: ${player!.displayName} ${player!.uid}');
    });
  }

  @override
  void dispose() {
    this._userServiceSub?.cancel();
    this._uploadFileSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors2222.black,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Elige tu proyecto',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 16,
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 10,
          ),
          ButtonWidget(
            color: this.widget.color,
            icon: Icons.upload_file_rounded,
            text: 'Subir archivo',
            onClicked: _uploadFile,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _uploadFile() {
    if (this._uploadFileSub != null) return;

    UploadFileService uploadFileService =
        Provider.of<UploadFileService>(context, listen: false);

    this._uploadFileSub = uploadFileService
        .uploadFile$('players/${player!.uid}/${this.widget.city.name}/',
            this.widget.city)
        .switchMap((projectFile) => this
            .widget
            ._uploadProjectService
            .project$(this.widget.city, projectFile))
        .listen((sended) {
      if (sended) {
        bool medalFound = false;

        /// seeks for all medals in the medals array
        player!.projectAwards.asMap().forEach((key, value) {
          if (value.cityId == this.widget.city.name) {
            medalFound = true;
            print('hay medalla');
          }
        });

        /// if there is no medal with the city name, creates new one
        if (!medalFound) {
          print('no hay medalla');
          UploadProjectService.writeMedal(player!.uid, this.widget.city.name);
        }
      }
    }, onDone: () {
      this._uploadFileSub?.cancel();
      this._uploadFileSub = null;
      Navigator.pop(context);
    });
  }
}

/// creates a custom elevated button [color] is needed to create the button
/// with the city color, [text] is the string of the button, [icon] is the icon
/// at the head of the button, [onClicked] is the function that will be
/// executed on pressed
class ButtonWidget extends StatelessWidget {
  final Color color;
  final String? text;
  final IconData? icon;
  final VoidCallback? onClicked;
  const ButtonWidget({
    Key? key,
    required this.color,
    this.text,
    this.onClicked,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      onPressed: onClicked,
      child: buildContent(textTheme),
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
    );
  }

  Widget buildContent(TextTheme textTheme) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          (icon != null)
              ? Icon(
                  icon,
                  color: Colors2222.black,
                )
              : Container(),
          SizedBox(
            width: 12,
          ),
          Text(
            text ?? '',
            style: textTheme.bodyText1,
          ),
        ],
      ),
    );
  }
}

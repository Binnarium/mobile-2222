import 'dart:async';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-player.widget.dart';
import 'package:lab_movil_2222/cities/project/models/player-projects.model.dart';
import 'package:lab_movil_2222/cities/project/services/load-project-files.service.dart';
import 'package:lab_movil_2222/cities/project/services/upload-file.service.dart';
import 'package:lab_movil_2222/cities/project/services/upload-project.service.dart';
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
  const CityProjectScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  static const String route = '/project';

  final CityModel city;

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

    /// load the provider to load the projectDTO
    final LoadProjectDtoService loadProjectDtoService =
        Provider.of<LoadProjectDtoService>(context, listen: false);

    /// calls the service to load the projectDTO
    _loadProjectDtoSub = loadProjectDtoService.load$(widget.city).listen(
      (projectDto) {
        if (mounted) {
          setState(() {
            project = projectDto;
          });
        }
      },
    );

    /// stream of projects
    final LoadProjectFiles loadProjectFiles =
        Provider.of<LoadProjectFiles>(context, listen: false);
    _userProjectsSub = loadProjectFiles.load$(widget.city).listen(
      (projects) {
        if (mounted) {
          setState(() {
            playerProjects = projects;
          });
        }
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
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: widget.city,

      backgrounds: const [
        BackgroundDecorationStyle.topRight,
        BackgroundDecorationStyle.path
      ],
      route: CityProjectScreen.route,
      body: _projectSheet(
          context, size, widget.city.color, userUID, playerProjects),
    );
  }

  Widget _projectSheet(BuildContext context, Size size, Color color,
      String? userUID, List<PlayerProject>? playerProjects) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final horizontalPadding =
        EdgeInsets.symmetric(horizontal: size.width * 0.08);
    return ListView(
      children: [
        /// icon item
        Padding(
          padding: const EdgeInsets.only(
            bottom: 32.0,
          ),
          child: LogosHeader(
            showStageLogoCity: widget.city,
          ),
        ),

        Center(
          child: SizedBox(
            width: min(300, size.width * 0.9),
            child: Text(
              'PROYECTO DOCENTE'.toUpperCase(),
              style: textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),
        ),

        ///
        const SizedBox(
          height: 24,
        ),

        Center(
          child: Image(
            image: const CoinsImages.project(),
            alignment: Alignment.bottomRight,
            fit: BoxFit.contain,
            width: min(160, size.width * 0.4),
          ),
        ),

        ///
        const SizedBox(
          height: 32,
        ),

        ///
        if (project == null)
          const AppLoading()
        else ...[
          Padding(
            padding: horizontalPadding,
            child: Text(
              project!.activity,
              style: textTheme.headline6!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(
            height: 28,
          ),

          ///
          Padding(
            padding: horizontalPadding,
            child: Markdown2222(
              data: project!.explanation,
              contentAlignment: WrapAlignment.start,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          /// if audio is available then show the audio player
          if (project!.audio != null) ...[
            Container(
              alignment: Alignment.center,
              padding: horizontalPadding,
              child: AudioPlayerWidget(
                audio: project!.audio!,
                color: widget.city.color,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],

          /// upload files
          if (project!.allowFile || project!.allowAudio) ...[
            Padding(
              padding: horizontalPadding,
              child: ProjectGalleryWidget(
                  city: widget.city,
                  userUID: userUID ?? '',
                  projects: playerProjects!),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: _taskButton(
                context,
                color,
                widget.city,
                project!,
              ),
            )
          ],
        ],
      ],
    );
  }
}


Widget _taskButton(
    BuildContext context, Color color, CityModel city, ProjectDto project) {
  final double buttonWidth = MediaQuery.of(context).size.width;
  return Container(
    width: buttonWidth,
    margin: const EdgeInsets.symmetric(horizontal: 40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 5,
      ),

      ///Navigates to main screen
      onPressed: () async {
        return showDialog(
            context: context,
            builder: (context) {
              /// creates the alert dialog to upload file
              return UploadFileDialog(
                city: city,
                color: color,
                projectDto: project,
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
  const UploadFileDialog({
    Key? key,
    required this.color,
    required this.city,
    required this.projectDto,
  }) : super(key: key);

  final Color color;
  final CityModel city;
  final ProjectDto projectDto;

  @override
  _UploadFileDialogState createState() => _UploadFileDialogState();
}

class _UploadFileDialogState extends State<UploadFileDialog> {
  StreamSubscription? _userServiceSub;
  StreamSubscription? _uploadFileSub;
  PlayerModel? currentPlayer;

  CurrentPlayerService get _currentPlayerService =>
      Provider.of<CurrentPlayerService>(context, listen: false);

  UploadProjectService get _uploadProjectService =>
      Provider.of<UploadProjectService>(context, listen: false);

  @override
  void initState() {
    super.initState();
    _userServiceSub = _currentPlayerService.player$.listen((player) {
      setState(() {
        currentPlayer = player;
      });
    });
  }

  @override
  void dispose() {
    _userServiceSub?.cancel();
    _uploadFileSub?.cancel();
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
          const SizedBox(
            height: 16,
          ),
          const SizedBox(height: 8),
          const SizedBox(
            height: 10,
          ),
          ButtonWidget(
            color: widget.color,
            icon: Icons.upload_file_rounded,
            text: 'Subir archivo',
            onClicked: _uploadFile,
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }

  void _uploadFile() {
    if (_uploadFileSub != null) {
      return;
    }

    final UploadFileService uploadFileService =
        Provider.of<UploadFileService>(context, listen: false);

    _uploadFileSub = uploadFileService
        .uploadFile$('players/${currentPlayer!.uid}/${widget.city.name}/',
            widget.projectDto)
        .switchMap((projectFile) => _uploadProjectService.project$(
              widget.city,
              projectFile,
              widget.projectDto.allowAudio,
            ))
        .listen((sended) {
      if (sended) {
        bool medalFound = false;

        /// seeks for all medals in the medals array
        currentPlayer!.projectAwards.asMap().forEach((key, value) {
          if (value.cityId == widget.city.name) {
            medalFound = true;
            print('hay medalla');
          }
        });

        /// if there is no medal with the city name, creates new one
        if (!medalFound) {
          print('no hay medalla');
          UploadProjectService.writeMedal(currentPlayer!.uid, widget.city.name);
        }
      }
    }, onDone: () {
      _uploadFileSub?.cancel();
      _uploadFileSub = null;
      Navigator.pop(context);
    });
  }
}

/// creates a custom elevated button [color] is needed to create the button
/// with the city color, [text] is the string of the button, [icon] is the icon
/// at the head of the button, [onClicked] is the function that will be
/// executed on pressed
class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.color,
    this.text,
    this.onClicked,
    this.icon,
  }) : super(key: key);

  final Color color;
  final String? text;
  final IconData? icon;
  final VoidCallback? onClicked;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
      onPressed: onClicked,
      style: ElevatedButton.styleFrom(
        primary: color,
      ),
      child: buildContent(textTheme),
    );
  }

  Widget buildContent(TextTheme textTheme) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors2222.black,
            )
          else
            Container(),
          const SizedBox(
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

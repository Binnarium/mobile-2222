import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/audio/ui/audio-player.widget.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/player-projects.dto.dart';
import 'package:lab_movil_2222/models/project.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';
import 'package:lab_movil_2222/services/load-project-activity.service.dart';
import 'package:lab_movil_2222/services/upload-file.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/project-gallery.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
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

  List<PlayerProject>? playerProjects = [];
  ProjectDto? project;

  StreamSubscription? _userProjectsSub;
  String? userUID;
  @override
  void initState() {
    super.initState();

    userUID = FirebaseAuth.instance.currentUser!.uid;

    /// called service to load the next chapter
    ILoadInformationService<List<CityDto>> loader = LoadCitiesSettingService();
    loader.load().then((value) => this.setState(() => this.chapters = value));

    this
        .widget
        .projectLoader
        .load()
        .then((value) => this.setState(() => this.project = value));

    /// stream of projects
    this._userProjectsSub =
        LoadPlayerInformationService.loadProjects$(userUID!)!
            .listen((projects) {
      this.setState(() {
        this.playerProjects = projects;
      });
    });
  }

  @override
  void dispose() {
    _userProjectsSub?.cancel();
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
      body: _projectSheet(context, size, this.widget.city.color, userUID!,
          this.playerProjects!),
    );
  }

  _projectSheet(BuildContext context, Size size, Color color, String userUID,
      List<PlayerProject> playerProjects) {
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
              "PROYECTO PERSONAL DE INNOVACIÓN DOCENTE",
              style: textTheme.headline5!.copyWith(
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),

        ///
        SizedBox(
          height: 16,
        ),

        ///
        if (this.project == null)
          AppLoading()
        else ...[
          Padding(
            padding: horizontalPadding,
            child: Text(
              this.project!.activity,
              style: textTheme.headline5!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 32,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          ///
          SizedBox(
            height: 28,
          ),
          Center(
            child: Image.asset(
              'assets/images/reto.png',
              alignment: Alignment.bottomRight,
              fit: BoxFit.contain,
              width: min(160, size.width * 0.4),
            ),
          ),
          SizedBox(
            height: 32,
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
          Padding(
            padding: horizontalPadding,
            child: ProjectGalleryWidget(
                city: this.widget.city,
                userUID: userUID,
                projects: playerProjects),
          ),

          Padding(
            padding: EdgeInsets.only(bottom: 50),
            child: _taskButton(
              context,
              color,
              this.widget.city.name,
            ),
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

/// Creates alert dialog to upload file [color] is needed to create the button
/// with the city color
class UploadFileDialog extends StatefulWidget {
  final Color color;
  final String cityName;
  const UploadFileDialog({
    Key? key,
    required this.color,
    required this.cityName,
  }) : super(key: key);

  @override
  _UploadFileDialogState createState() => _UploadFileDialogState();
}

class _UploadFileDialogState extends State<UploadFileDialog> {
  StreamSubscription? _userServiceSub;
  UploadTask? task;
  String? userUID;
  File? file;
  String? fileName;
  PlayerModel? player;

  @override
  void initState() {
    super.initState();
    this._userServiceSub = UserService.instance.user$().listen((event) {
      userUID = event!.uid;
      LoadPlayerInformationService playerLoader =
          LoadPlayerInformationService();
      playerLoader.loadInformation(event.uid).then((value) => this.setState(() {
            this.player = value;
          }));
    });
  }

  @override
  void dispose() {
    _userServiceSub?.cancel();
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
            (file == null) ? 'Elige tu proyecto' : 'Sube tu proyecto',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(
            height: 16,
          ),
          ButtonWidget(
            color: this.widget.color,
            text: 'Elegir archivo',
            icon: Icons.attach_file_rounded,
            onClicked: selectFile,
          ),
          SizedBox(height: 8),
          Text(
            fileName ?? 'No se ha seleccionado el archivo',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: 10,
          ),
          ButtonWidget(
            color: this.widget.color,
            icon: Icons.upload_file_rounded,
            text: 'Subir archivo',
            onClicked: uploadFile,
          ),
          SizedBox(
            height: 10,
          ),
          task != null ? buildUploadStatus(task!) : Container(),
        ],
      ),
    );
  }

  Future selectFile() async {
    print('User UID: $userUID');

    final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: (this.widget.cityName != "Angkor")
            ? ['pdf']
            : ['mp3', 'wav', 'm4p', 'ogg', 'wma', '3gp']);
    if (result == null) return;

    /// to get the path of the file
    final path = result.files.single.path!;

    setState(() {
      file = File(path);
      fileName = result.files.single.name;
    });
  }

  /// to upload a file
  Future uploadFile() async {
    print('User UID: $userUID');
    if (file == null) return;

    final destination = 'players/$userUID/${this.widget.cityName}/$fileName';
    print("LOCATION: $destination");
    task = UploadFileToFirebaseService.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    bool medalFound = false;
    final snapshot = await task!.whenComplete(
      () => {
        /// seeks for all medals in the medals array
        player!.projectAwards.asMap().forEach((key, value) {
          if (value.cityId == this.widget.cityName) {
            medalFound = true;
            print('hay medalla');
          }
        }),

        /// if there is no medal with the city name, creates new one
        if (!medalFound)
          {
            print('no hay medalla'),
            UploadFileToFirebaseService.writeMedal(
                userUID!, this.widget.cityName),
          }
      },
    );
    final urlDownload = await snapshot.ref.getDownloadURL();

    /// creates a playerProject instance for this project
    PlayerProject currentProject = PlayerProject.fromMap({
      "file": {"path": destination, "url": urlDownload},
      "cityID": this.widget.cityName,
      "kind": (this.widget.cityName != "Angkor") ? "PROJECT#PDF" : "PROJECT#MP3"
    });

    /// to write the project in the users project collection
    UploadFileToFirebaseService.writePlayerProjectFile(
        userUID!, currentProject);
    print('Download link: $urlDownload');
  }

  Widget buildUploadStatus(UploadTask uploadTask) =>
      StreamBuilder<TaskSnapshot>(
          stream: task!.snapshotEvents,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final snap = snapshot.data!;
              final progress = snap.bytesTransferred / snap.totalBytes;
              final percentage = (progress * 100).toStringAsFixed(1);
              return Text(
                (progress == 1.0)
                    ? '¡Subido con éxito!'
                    : 'Subiendo: $percentage %',
                style: Theme.of(context).textTheme.bodyText2,
              );
            } else {
              return Container();
            }
          });
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

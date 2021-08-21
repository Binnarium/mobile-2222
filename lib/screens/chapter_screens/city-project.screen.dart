import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/models/project.model.dart';
import 'package:lab_movil_2222/providers/audioPlayer_provider.dart';
import 'package:lab_movil_2222/services/current-user.service.dart';
import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/services/load-project-activity.service.dart';
import 'package:lab_movil_2222/services/upload-file.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/podcast_audioPlayer_widget.dart';
import 'package:lab_movil_2222/shared/widgets/scaffold-2222.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

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
      onPressed: () async {
        return await showDialog(
            context: context,
            builder: (context) {
              /// creates the alert dialog to upload file
              return UploadFileDialog(
                color: color,
              );
            });
      },
      child: Text(
        'Subir Tarea',
      ),
    ),
  );
}

/// Creates alert dialog to upload file [color] is needed to create the button
/// with the city color
class UploadFileDialog extends StatefulWidget {
  final Color color;
  const UploadFileDialog({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  _UploadFileDialogState createState() => _UploadFileDialogState();
}

class _UploadFileDialogState extends State<UploadFileDialog> {
  StreamSubscription? userService;
  UploadTask? task;
  String? userUID;
  File? file;
  @override
  Widget build(BuildContext context) {
    this.userService = UserService.instance.userUID$().listen((event) {
      userUID = event!.uid;
    });
    final fileName =
        file != null ? (file!.path) : 'No se ha seleccionado el archivo';
    return AlertDialog(
      backgroundColor: Colors2222.backgroundBottomBar,
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
            color: widget.color,
            text: 'Elegir archivo',
            icon: Icons.attach_file_rounded,
            onClicked: selectFile,
          ),
          SizedBox(height: 8),
          Text(
            fileName,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: 10,
          ),
          ButtonWidget(
            color: widget.color,
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
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;

    /// to get the path of the file
    final path = result.files.single.path!;
    setState(() {
      file = File(path);
    });
  }

  /// to upload a file
  Future uploadFile() async {
    print('User UID: $userUID');
    if (file == null) return;
    final fileName = file!.path;
    final destination = 'players/$userUID/$fileName';

    task = UploadFileToFirebaseService.uploadFile(destination, file!);
    setState(() {});
    if (task == null) return;

    final snapshot = await task!.whenComplete(() => {});
    final urlDownload = await snapshot.ref.getDownloadURL();
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
                  color: Colors2222.backgroundBottomBar,
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

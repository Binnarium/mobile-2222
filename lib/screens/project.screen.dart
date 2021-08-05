import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/models/Login.model.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/podcast_audioPlayer_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

class ProjectScreen extends StatefulWidget {
  static const String route = '/project';

  @override
  _ProjectScreenState createState() => _ProjectScreenState();

  LoginDto? loginPayload;
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  void initState() {
    super.initState();

    ILoadInformationService<LoginDto> loader = LoadLoginInformationService();
    loader
        .load()
        .then((value) => this.setState(() => this.widget.loginPayload = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: ColorsApp.backgroundRed,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen
            _resourcesContent(size, context),
          ],
        ),
      ),
    );
  }

  ///body of the screen
  _resourcesContent(Size size, BuildContext context) {
    ///sizing the container to the mobile
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),

      ///Listview of the whole screen
      child: ListView(
        children: [
          if (this.widget.loginPayload == null)
            Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  ColorsApp.backgroundRed,
                ),
              ),
            ),

          /// data is available
          /// logo de 2222
          if (this.widget.loginPayload != null) ...[
            SizedBox(
              height: 40,
            ),
            _projectSheet(context, size),
            SizedBox(
              height: 10,
            ),
          ],
        ],
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

  _projectSheet(BuildContext context, Size size) {
    return Container(
        child: Column(
      children: [
        SizedBox(
          height: 10,
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
        Container(
          alignment: Alignment.center,
          child: PodcastAudioPlayer(
            audioUrl: "",
            description: "",
            color: Colors.white,
          ),
        ),
        SizedBox(
          height: 60,
        ),
        _taskButton(context)
      ],
    ));
  }
}

_taskButton(BuildContext context) {
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
        style: korolevFont.headline6?.apply(color: ColorsApp.backgroundRed),
      ),
    ),
  );
}

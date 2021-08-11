import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class TeamScreen extends StatefulWidget {
  static const String route = '/equipo';

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  WelcomeDto? loginPayload;

  @override
  void initState() {
    super.initState();

    ILoadInformationService<WelcomeDto> loader = LoadLoginInformationService();
    loader
        .load()
        .then((value) => this.setState(() => this.loginPayload = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            ChapterBackgroundWidget(
              backgroundColor: ColorsApp.backgroundRed,
              reliefPosition: 'top-right',
            ),
            _routeCurve(),

            ///body of the screen
            _resourcesContent(context),
          ],
        ),
      ),
    );
  }

  ///body of the screen
  _resourcesContent(BuildContext context) {
    if (this.loginPayload == null)
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            ColorsApp.backgroundRed,
          ),
        ),
      );

    final Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// back button to return previous page
          BackButton(color: Colors.white),

          /// page content
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.1,
              vertical: 24,
            ),
            child: TeamContentMarkdown(
              teamContent: this.loginPayload!.teamText,
            ),
          ),
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
}

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';
import 'package:lab_movil_2222/services/load-team.service.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class TeamScreen extends StatefulWidget {
  static const String route = '/team';

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  TeamDto? teamDto;

  @override
  void initState() {
    super.initState();

    ILoadInformationService<TeamDto> loader = LoadTeamService();
    loader
        .load()
        .then((value) => this.setState(() => this.teamDto = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            /// Ignore deprecated cause Scaffold 2222 needs city as param
            // ignore: deprecated_member_use_from_same_package
            ChapterBackgroundWidget(
              backgroundColor: Colors2222.red,
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
    if (this.teamDto == null)
      return Center(
        child: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(
            Colors2222.red,
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
              teamContent: this.teamDto!.teamText,
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

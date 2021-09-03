import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/team/models/team.model.dart';
import 'package:lab_movil_2222/team/services/load-team.service.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class TeamScreen extends StatefulWidget {
  static const String route = '/team';

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  TeamModel? teamDto;

  @override
  void initState() {
    super.initState();

    ILoadInformationService<TeamModel> loader = LoadTeamService();
    loader.load().then((value) => this.setState(() => this.teamDto = value));
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.empty(
      backgrounds: [
        BackgroundDecorationStyle.path,
        BackgroundDecorationStyle.bottomRight
      ],
      appBar: AppBar(
        backgroundColor: Colors2222.red,
      ),
      body: (this.teamDto == null)
          ? Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                  Colors2222.red,
                ),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: 24,
              ),
              child: TeamContentMarkdown(
                teamContent: this.teamDto!.teamText,
              ),
            ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/team/models/team.model.dart';
import 'package:lab_movil_2222/team/services/load-team.service.dart';
import 'package:lab_movil_2222/team/ui/widgets/team-content-markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class TeamScreen extends StatefulWidget {
  static const String route = '/team';

  @override
  _TeamScreenState createState() => _TeamScreenState();
}

class _TeamScreenState extends State<TeamScreen> {
  TeamModel? teamDto;

  StreamSubscription? _loadTeamSub;

  @override
  void initState() {
    super.initState();

    LoadTeamService loadTeamService =
        Provider.of<LoadTeamService>(this.context, listen: false);

    this._loadTeamSub = loadTeamService.load$().listen(
      (teamModel) {
        if (this.mounted)
          this.setState(() {
            this.teamDto = teamModel;
          });
      },
    );
  }

  @override
  void dispose() {
    this._loadTeamSub?.cancel();
    super.dispose();
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

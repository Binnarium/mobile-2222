import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/team/models/team.model.dart';
import 'package:lab_movil_2222/team/services/load-team.service.dart';
import 'package:lab_movil_2222/team/ui/widgets/team-content-markdown.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({Key? key}) : super(key: key);

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

    final LoadTeamService loadTeamService =
        Provider.of<LoadTeamService>(context, listen: false);

    _loadTeamSub = loadTeamService.load$().listen(
      (teamModel) {
        if (mounted) {
          setState(() {
            teamDto = teamModel;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadTeamSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.navigation(
      activePage: null,
      backgrounds: const [
        BackgroundDecorationStyle.path,
        BackgroundDecorationStyle.bottomRight
      ],
      body: (teamDto == null)
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors2222.red,
                ),
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.1,
                vertical: 80,
              ),
              child: TeamContentMarkdown(
                teamContent: teamDto!.teamText,
              ),
            ),
    );
  }
}

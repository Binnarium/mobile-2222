import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/cities/contribution/models/contribution-explanation.model.dart';
import 'package:lab_movil_2222/cities/contribution/services/get-contribution-explanation.service.dart';
import 'package:lab_movil_2222/cities/contribution/ui/widget/contribution-code-copy.dart';
import 'package:lab_movil_2222/cities/contribution/ui/widget/goto-pub-button.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class ContributionExplanationScreen extends StatefulWidget {
  /// constructor
  const ContributionExplanationScreen({Key? key, required this.city})
      : super(key: key);

  /// params
  static const String route = '/contribution-explanation';
  final CityModel city;

  @override
  _ContributionExplanationScreenState createState() =>
      _ContributionExplanationScreenState();
}

class _ContributionExplanationScreenState
    extends State<ContributionExplanationScreen> {
  StreamSubscription? _explanationSub;

  ContributionExplanationModel? contributionExplanation;

  PlayerModel? player;
  StreamSubscription? playerSub;

  @override
  void initState() {
    super.initState();

    final GetContributionExplanationService clubhouseExplanationService =
        Provider.of<GetContributionExplanationService>(context, listen: false);
    _explanationSub = clubhouseExplanationService.explanation$.listen(
      (event) {
        if (mounted) {
          setState(() {
            contributionExplanation = event;
          });
        }
      },
    );

    playerSub = _currentPlayer.player$.listen((event) {
      setState(() {
        player = event;
      });
    });
  }

  @override
  void dispose() {
    _explanationSub?.cancel();
    playerSub?.cancel();
    super.dispose();
  }

  CurrentPlayerService get _currentPlayer =>
      Provider.of<CurrentPlayerService>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: widget.city,
      // ignore: prefer_const_literals_to_create_immutables
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: ContributionExplanationScreen.route,
      body: ListView(
        children: [
          /// icon item
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: LogosHeader(showStageLogoCity: widget.city),
          ),

          /// page header
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 24.0),
              width: min(350, size.width * 0.8),
              child: Text(
                'Manifiesto-wiki por la Educación'.toUpperCase(),
                style: textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /// page content
          if (contributionExplanation == null)
            // ignore: prefer_const_constructors
            AppLoading()
          else ...[
            /// video provider
            Padding(
              padding: EdgeInsets.only(
                bottom: 30.0,
                right: size.width * 0.08,
                left: size.width * 0.08,
              ),
              child: VideoPlayer(video: contributionExplanation!.video),
            ),

            /// content
            Padding(
              padding: EdgeInsets.only(
                bottom: 30.0,
                right: size.width * 0.08,
                left: size.width * 0.08,
              ),
              child: Markdown2222(
                data: contributionExplanation!.explanation,
              ),
            ),

            if (player != null && player!.pubUserId == null)
              Padding(
                padding: EdgeInsets.only(
                  bottom: 30.0,
                  right: size.width * 0.08,
                  left: size.width * 0.08,
                ),
                child: ContributionCodeCopy(
                  codeExplanation: contributionExplanation!.codeExplanation,
                  pubCode: player!.pubCode,
                  primaryColor: widget.city.color,
                ),
              ),

            /// join room link
            Container(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
                right: size.width * 0.08,
                bottom: 28,
              ),
              alignment: Alignment.center,
              child:
                  GotoPubButton(pubUrl: contributionExplanation!.manifestUrl),
            ),
          ],
        ],
      ),
    );
  }
}

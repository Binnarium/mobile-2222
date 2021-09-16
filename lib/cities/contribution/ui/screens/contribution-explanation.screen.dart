import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/cities/contribution/models/contribution-explanation.model.dart';
import 'package:lab_movil_2222/cities/contribution/services/get-clubhouse-explanation.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContributionExplanationScreen extends StatefulWidget {
  static const String route = '/contribution-explanation';
  final CityModel city;

  const ContributionExplanationScreen({Key? key, required this.city})
      : super(key: key);

  @override
  _ContributionExplanationScreenState createState() =>
      _ContributionExplanationScreenState();
}

class _ContributionExplanationScreenState
    extends State<ContributionExplanationScreen> {
  StreamSubscription? _explanationSub;

  ContributionExplanationModel? contributionExplanation;

  @override
  void initState() {
    super.initState();

    GetContributionExplanationService clubhouseExplanationService =
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
  }

  @override
  void dispose() {
    _explanationSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: widget.city,
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
              width: min(300, size.width * 0.8),
              child: Text(
                'Manifiesto por la Educación'.toUpperCase(),
                style: textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /// page content
          if (contributionExplanation == null)
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

            /// join room link
            Padding(
              padding: EdgeInsets.only(
                bottom: 30.0,
                right: size.width * 0.08,
                left: size.width * 0.08,
              ),
              child: ElevatedButton(
                onPressed: () => launch(contributionExplanation!.manifestUrl),
                style: TextButton.styleFrom(
                  primary: Colors2222.white,
                  backgroundColor: Colors2222.black,
                ),
                child: Text(
                  'Lee nuestro manifiesto',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

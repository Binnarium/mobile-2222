import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-explanation.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/get-clubhouse-explanation.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubhouseExplanationScreen extends StatefulWidget {
  const ClubhouseExplanationScreen({Key? key, required this.city})
      : super(key: key);

  static const String route = '/chapterClubhouseExplanation';
  final CityModel city;

  @override
  _ClubhouseExplanationScreenState createState() =>
      _ClubhouseExplanationScreenState();
}

class _ClubhouseExplanationScreenState
    extends State<ClubhouseExplanationScreen> {
  StreamSubscription? _explanationSub;

  ClubhouseExplanationModel? clubhouseExplanation;

  @override
  void initState() {
    super.initState();

    final GetClubhouseExplanationService clubhouseExplanationService =
        Provider.of<GetClubhouseExplanationService>(context, listen: false);
    _explanationSub = clubhouseExplanationService.explanation$.listen(
      (event) {
        if (mounted) {
          setState(() {
            clubhouseExplanation = event;
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
      backgrounds: const [BackgroundDecorationStyle.topRight],
      route: ClubhouseExplanationScreen.route,
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
                'CLUBHOUSE'.toUpperCase(),
                style: textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /// page content
          if (clubhouseExplanation == null)
            const AppLoading()
          else ...[
            /// video provider
            Padding(
              padding: EdgeInsets.only(
                bottom: 30.0,
                right: size.width * 0.08,
                left: size.width * 0.08,
              ),
              child: VideoPlayer(video: clubhouseExplanation!.video),
            ),

            /// content
            Padding(
              padding: EdgeInsets.only(
                bottom: 30.0,
                right: size.width * 0.08,
                left: size.width * 0.08,
              ),
              child: Markdown2222(
                data: clubhouseExplanation!.explanation,
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
                onPressed: () => launch(clubhouseExplanation!.clubUrl),
                style: TextButton.styleFrom(
                  primary: Colors2222.white,
                  backgroundColor: Colors2222.black,
                ),
                child: const Text(
                  'Únete a nuestro room de clubhouse',
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-explanation.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/get-clubhouse-explanation.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubhouseExplanationWidget extends StatefulWidget {
  const ClubhouseExplanationWidget({
    Key? key,
  }) : super(key: key);

  @override
  _ClubhouseExplanationWidgetState createState() =>
      _ClubhouseExplanationWidgetState();
}

class _ClubhouseExplanationWidgetState
    extends State<ClubhouseExplanationWidget> {
  StreamSubscription? _explanationSub;

  ClubhouseExplanationModel? clubhouseExplanation;

  @override
  void initState() {
    super.initState();

    GetClubhouseExplanationService clubhouseExplanationService =
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
    final Size size = MediaQuery.of(context).size;
    return clubhouseExplanation == null
        ? AppLoading()
        : Container(
            decoration: BoxDecoration(
              color: Colors2222.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                /// video provider
                VideoPlayer(video: clubhouseExplanation!.video),

                /// content
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 30.0,
                    horizontal: size.width * 0.08,
                  ),
                  child: Markdown2222(
                    data: clubhouseExplanation!.explanation,
                    color: Colors2222.black,
                  ),
                ),

                /// join room link
                Padding(
                  padding: EdgeInsets.only(
                    bottom: 30.0,
                    right: size.width * 0.08,
                    left: size.width * 0.08,
                  ),
                  child: TextButton(
                    onPressed: () => launch(clubhouseExplanation!.clubUrl),
                    style: TextButton.styleFrom(
                      primary: Colors2222.primary,
                    ),
                    child: Text(
                      'Únete a nuestro room de clubhouse'.toUpperCase(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

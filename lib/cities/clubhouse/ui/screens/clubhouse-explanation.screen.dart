import 'dart:math';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse-activity.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/models/clubhouse.model.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/load-clubhouse-activity.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class ClubhouseExplanationScreen extends StatefulWidget {
  static const String route = '/chapterClubhouseExplanation';
  final CityDto city;

  const ClubhouseExplanationScreen({Key? key, required this.city}) : super(key: key);

  @override
  _ClubhouseExplanationScreenState createState() => _ClubhouseExplanationScreenState();
}

class _ClubhouseExplanationScreenState extends State<ClubhouseExplanationScreen> {
  List<ClubhouseModel>? clubhouses;
  ClubhouseActivityModel? clubhouseActivity;

  @override
  void initState() {
    super.initState();

    LoadClubhouseService(city: this.widget.city).load().then((event) {
      this.setState(() {
        this.clubhouseActivity = event;
      });
    });
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.topRight],
      route: ClubhouseExplanationScreen.route,
      body: ListView(
        children: [
          /// icon item
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: LogosHeader(
              showStageLogoCity: this.widget.city,
            ),
          ),

          /// page header
          Center(
            child: Container(
              padding: const EdgeInsets.only(bottom: 24.0),
              width: min(300, size.width * 0.8),
              child: Text(
                "CLUBHOUSE".toUpperCase(),
                style: textTheme.headline4!.copyWith(
                  fontWeight: FontWeight.w400,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /// page content
          if (this.clubhouseActivity == null)
            AppLoading()
          else ...[
            Padding(
              padding: EdgeInsets.only(
                bottom: 30.0,
                left: size.width * 0.08,
                right: size.width * 0.08,
              ),
              child: Markdown2222(
                data: this.clubhouseActivity!.explanation,
              ),
            )
          ],
        ],
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/contribution/models/collaborations.model.dart';
import 'package:lab_movil_2222/cities/contribution/services/get-collaboration-explanation.service.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

/// contribution activity page
class ContributionScreen extends StatefulWidget {
  /// constructor
  const ContributionScreen({
    Key? key,
    required this.city,
  }) : super(key: key);

  /// params
  static const String route = '/contribution-activity';

  /// current city
  final CityModel city;

  @override
  _ContributionScreenState createState() => _ContributionScreenState();
}

class _ContributionScreenState extends State<ContributionScreen> {
  late List<CityModel> chapters;
  CollaborationModel? collaborationActivityModel;
  StreamSubscription? collaborationActivitySub;

  ContributionService get _contributionService =>
      Provider.of<ContributionService>(context, listen: false);

  @override
  void initState() {
    super.initState();

    collaborationActivitySub =
        _contributionService.explanation$(widget.city).listen(
      (event) {
        setState(() {
          collaborationActivityModel = event;
        });
      },
    );
  }

  @override
  void deactivate() {
    collaborationActivitySub?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final Size size = MediaQuery.of(context).size;

    return Scaffold2222.city(
      city: widget.city,
      // ignore: prefer_const_literals_to_create_immutables
      backgrounds: [
        BackgroundDecorationStyle.bottomRight,
        BackgroundDecorationStyle.path
      ],
      route: ContributionScreen.route,
      body: ListView(
        children: [
          /// icon item
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: LogosHeader(showStageLogoCity: widget.city),
          ),

          /// page title
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

          /// medal icon
          Padding(
            padding: const EdgeInsets.only(bottom: 32),
            child: Center(
              child: Image(
                image: const CoinsImages.contribution(),
                alignment: Alignment.bottomRight,
                fit: BoxFit.contain,
                width: min(160, size.width * 0.4),
              ),
            ),
          ),

          /// collaboration data loading state
          if (collaborationActivityModel == null) ...[
            const AppLoading(),
          ]

          /// collaboration data
          else ...[
            /// activity title
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
                right: size.width * 0.08,
                bottom: 40,
              ),
              child: Text(
                collaborationActivityModel!.theme,
                style: textTheme.headline5,
                textAlign: TextAlign.center,
              ),
            ),

            /// activity explanation
            Padding(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
                right: size.width * 0.08,
                bottom: 28,
              ),
              child: Markdown2222(
                data: collaborationActivityModel!.explanation,
              ),
            ),

            ///
            if (collaborationActivityModel!.allowIdea)
              _contributionButton(
                context,
                'Sube una idea',
                widget.city,
                () {},
              ),
            if (collaborationActivityModel!.allowLecture)
              _contributionButton(
                context,
                'Comparte una lectura',
                widget.city,
                () {},
              ),
            if (collaborationActivityModel!.allowProject)
              _contributionButton(
                context,
                'Agrega un proyecto',
                widget.city,
                () {},
              ),
          ],
        ],
      ),
    );
  }
}

Widget _contributionButton(
    BuildContext context, String name, CityModel city, void Function() goto) {
  final double buttonWidth = MediaQuery.of(context).size.width;
  return Container(
    width: buttonWidth,
    margin: const EdgeInsets.symmetric(horizontal: 40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 5,
      ),

      ///Navigates to main screen
      onPressed: goto,
      child: Text(
        name,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors2222.black),
      ),
    ),
  );
}

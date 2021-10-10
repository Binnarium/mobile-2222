import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lab_movil_2222/cities/contribution/models/contribution.model.dart';
import 'package:lab_movil_2222/cities/contribution/services/contribution-activity.service.dart';
import 'package:lab_movil_2222/cities/contribution/ui/widget/goto-pub-button.dart';
import 'package:lab_movil_2222/cities/project/ui/widgets/coins_check.widget.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
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
  CollaborationModel? _contribution;
  StreamSubscription? collaborationActivitySub;
  StreamSubscription? _userServiceSub;

  late List<CityModel> chapters;
  bool hasMedal = false;

  ContributionActivityService get _contributionService =>
      Provider.of<ContributionActivityService>(context, listen: false);

  CurrentPlayerService get _currentPlayerService =>
      Provider.of<CurrentPlayerService>(context, listen: false);

  @override
  void initState() {
    super.initState();

    collaborationActivitySub =
        _contributionService.explanation$(widget.city).listen(
      (event) {
        setState(() {
          _contribution = event;
        });
      },
    );
    _userServiceSub = _currentPlayerService.player$.listen((player) {
      if (mounted) {
        setState(() {
          /// seeks for all medals in the medals array
          hasMedal = player!.contributionsAwards
              .any((el) => el.cityId == widget.city.id);
        });
      }
    });
  }

  @override
  void dispose() {
    collaborationActivitySub?.cancel();
    _userServiceSub?.cancel();
    super.dispose();
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
              width: min(350, size.width * 0.8),
              child: Text(
                'Manifiesto-wiki por la Educación'.toUpperCase(),
                style: textTheme.headline4,
                textAlign: TextAlign.center,
              ),
            ),
          ),

          /// medal icon
          Center(
            child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: CoinsCheckWidget(
                    coin: const MedalImage.contribution(),
                    hasMedal: hasMedal)),
          ),

          /// collaboration data loading state
          if (_contribution == null) ...[
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
                _contribution!.thematic,
                style: textTheme.headline6,
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
                data: _contribution!.explanation,
              ),
            ),

            ///
            Container(
              padding: EdgeInsets.only(
                left: size.width * 0.08,
                right: size.width * 0.08,
                bottom: 28,
              ),
              alignment: Alignment.center,
              child: GotoPubButton(pubUrl: _contribution!.pubUrl),
            ),
          ],
        ],
      ),
    );
  }
}

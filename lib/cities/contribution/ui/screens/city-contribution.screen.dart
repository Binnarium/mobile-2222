import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/cities/contribution/models/collaborations-activity.model.dart';
import 'package:lab_movil_2222/cities/contribution/services/get-collaboration-explanation.service.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/player/models/coinsImages.model.dart';
import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class YourContributionScreen extends StatefulWidget {
  static const String route = '/contribution-activity';

  final CityDto city;

  YourContributionScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        super(key: key);

  @override
  _YourContributionScreenState createState() => _YourContributionScreenState();
}

class _YourContributionScreenState extends State<YourContributionScreen> {
  late List<CityDto> chapters;
  CollaborationActivityModel? collaborationActivityModel;
  StreamSubscription? collabActivitySub;

  @override
  void initState() {
    super.initState();
    ILoadInformationService<List<CityDto>> loader = LoadCitiesSettingService();
    loader.load().then((value) => this.setState(() => this.chapters = value));
    this.collabActivitySub =
        GetContributionActivityService.explanation$(this.widget.city)
            .listen((event) {
      this.setState(() {
        this.collaborationActivityModel = event;
      });
    });
  }

  @override
  void deactivate() {
    this.collabActivitySub?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold2222.city(
      city: this.widget.city,
      backgrounds: [
        BackgroundDecorationStyle.bottomRight,
        BackgroundDecorationStyle.path
      ],
      route: YourContributionScreen.route,
      body: _projectSheet(context, size, this.widget.city.color),
    );
  }

  _projectSheet(BuildContext context, Size size, Color color) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView(
      children: [
        /// icon item
        Padding(
          padding: const EdgeInsets.only(bottom: 50.0),
          child: LogosHeader(
            showStageLogoCity: this.widget.city,
          ),
        ),

        Center(
          child: Container(
            padding: const EdgeInsets.only(bottom: 24.0),
            width: min(300, size.width * 0.8),
            child: Text(
              "Manifiesto por la Educación".toUpperCase(),
              style: textTheme.headline4,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Center(
            child: Image(
              image: CoinsImages.contribution(),
              alignment: Alignment.bottomRight,
              fit: BoxFit.contain,
              width: min(160, size.width * 0.4),
            ),
          ),
        ),

        if (this.collaborationActivityModel == null) ...[
          AppLoading(),
        ] else ...[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
            child: Text(
              this.collaborationActivityModel!.theme,
              style: textTheme.headline5,
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.08, vertical: 50),
            child: MarkdownBody(
              data: this.collaborationActivityModel!.explanation,
              styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
                textAlign: WrapAlignment.center,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          if (this.collaborationActivityModel!.allowIdea)
            _contributionButton(
              context,
              'Sube una idea',
              this.widget.city,
              () {},
            ),
          if (this.collaborationActivityModel!.allowLecture)
            _contributionButton(
              context,
              'Comparte una lectura',
              this.widget.city,
              () {},
            ),
          if (this.collaborationActivityModel!.allowProject)
            _contributionButton(
              context,
              'Agrega un proyecto',
              this.widget.city,
              () {},
            ),
        ],
      ],
    );
  }
}

_contributionButton(
    BuildContext context, String name, CityDto city, void Function() goto) {
  double buttonWidth = MediaQuery.of(context).size.width;
  return Container(
    width: buttonWidth,
    margin: EdgeInsets.symmetric(horizontal: 40),
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

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/contribution-ideas.screen.dart';

import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class CityContributionScreen extends StatefulWidget {
  static const String route = '/contribution';

  final CityDto city;

  CityContributionScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        super(key: key);

  @override
  _CityColaborationScreenState createState() => _CityColaborationScreenState();
}

class _CityColaborationScreenState extends State<CityContributionScreen> {
  late List<CityDto> chapters;

  @override
  void initState() {
    super.initState();
    ILoadInformationService<List<CityDto>> loader = LoadCitiesSettingService();
    loader.load().then((value) => this.setState(() => this.chapters = value));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold2222(
      city: this.widget.city,
      backgrounds: [
        BackgroundDecorationStyle.bottomRight,
        BackgroundDecorationStyle.path
      ],
      route: CityContributionScreen.route,
      body: _projectSheet(context, size, this.widget.city.color),
    );
  }

  _projectSheet(BuildContext context, Size size, Color color) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ListView(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 50),
        children: [
          Text(
            "TU CONTRIBUCIÓN",
            style: textTheme.headline4!.apply(fontWeightDelta: 2),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 16,
          ),
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth * 0.7,
              padding: EdgeInsets.only(bottom: 16),
              child: Stack(
                children: [
                  /// text
                  Container(
                    padding: EdgeInsets.only(
                      top: 16,
                      bottom: 80,
                      right: constraints.maxWidth * 0.35,
                      left: constraints.maxWidth * 0.05,
                    ),
                    child: Text(
                      'Deja tu contribución de ${this.widget.city.name}',
                      style: textTheme.headline6,
                      textAlign: TextAlign.center,
                    ),
                  ),

                  /// path background
                  Positioned.fill(
                    child: LayoutBuilder(
                      builder: (context, constraints) => Image.asset(
                        'assets/images/path-project.png',
                        alignment: Alignment.bottomRight,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          MarkdownBody(
            data:
                'Las contribuciones son el pilar fundamental de nuestro viaje mítico donde dejaremos nuestras experiencias y expectativas para la siguiente etapa',
            styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
              textAlign: WrapAlignment.center,
            ),
          ),
          SizedBox(
            height: 16,
          ),
          _contributionButton(context, color, 'Idea', this.widget.city),
          _contributionButton(context, color, 'Lecture', this.widget.city),
          _contributionButton(context, color, 'Project', this.widget.city),
        ]);
  }
}

_contributionButton(BuildContext context, color, String option, CityDto city) {
  double buttonWidth = MediaQuery.of(context).size.width;
  String name = '';
  if (option == 'Idea') {
    name = 'Idea';
  } else if (option == 'Lecture') {
    name = 'Lectura';
  } else {
    name = 'Proyecto';
  }
  return Container(
    width: buttonWidth,
    margin: EdgeInsets.symmetric(horizontal: 40),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Colors.white,
        elevation: 5,
      ),

      ///Navigates to main screen
      onPressed: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ContributionIdeasScreen(city: city, option: option),
        ),
      ),
      child: Text(
        'Contribucción de ${name}',
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors2222.black),
      ),
    ),
  );
}

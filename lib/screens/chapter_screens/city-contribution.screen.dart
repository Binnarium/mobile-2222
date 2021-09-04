import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/contribution-ideas.screen.dart';
import 'package:lab_movil_2222/services/load-cities-settings.service.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class YourContributionScreen extends StatefulWidget {
  static const String route = '/your_contribution';

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

  @override
  void initState() {
    super.initState();
    ILoadInformationService<List<CityDto>> loader = LoadCitiesSettingService();
    loader.load().then((value) => this.setState(() => this.chapters = value));
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

    return ListView(children: [
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
            "TU CONTRIBUCIÓN",
            style: textTheme.headline4!.copyWith(
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SizedBox(
        height: 16,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
        child: LayoutBuilder(
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
                    
                  ),
                  child: Text(
                    'A través de la experiencia propia, el docente expande los contenidos y agrega valor a la conversación de la comunidad 2222. Para ganar premios, se deben hacer aportes sobre la temática de la ciudad en una o ambas consignas.',
                    style: textTheme.headline6,
                    textAlign: TextAlign.center,
                  ),
                ),

                
              ],
            ),
          ),
        ),
      ),
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 30),
        child: MarkdownBody(
          data:
              'a)Escribe una idea que no hayas encontrado en tu viaje por la ciudad. Hazlo en un máximo de 20 líneas de texto y una recomendación de lectura.        \nb) Comparte con la comunidad una buena práctica que conozcas, propia o de algún colega o equipo. Hazlo en un máximo de 10 líneas de texto y un enlace de referencia.',
          styleSheet: MarkdownStyleSheet.fromTheme(theme).copyWith(
            textAlign: WrapAlignment.center,
          ),
        ),
      ),
      SizedBox(
        height: 16,
      ),
      _contributionButton(context, color, 'Idea', this.widget.city),
      
      _contributionButton(context, color, 'Práctica', this.widget.city),
      
    ]);
  }
}

_contributionButton(BuildContext context, color, String option, CityDto city) {
  double buttonWidth = MediaQuery.of(context).size.width;
  String name = '';
  if (option == 'Idea') {
    name = 'Sube tu idea y enlace';
  } else if (option == 'Práctica') {
    name = 'Sube tu buena práctica';
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
        name,
        style: Theme.of(context)
            .textTheme
            .bodyText1!
            .copyWith(color: Colors2222.black),
      ),
    ),
  );
}

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/city-introduction.dto.dart';
import 'package:lab_movil_2222/services/load-city-introduction.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class CityIntroductionScreen extends StatefulWidget {
  const CityIntroductionScreen({
    Key? key,
    required CityModel city,
  })  : city = city,
        super(key: key);

  static const String route = '/introduction';

  final CityModel city;

  @override
  _CityIntroductionScreenState createState() => _CityIntroductionScreenState();
}

class _CityIntroductionScreenState extends State<CityIntroductionScreen> {
  CityIntroductionDto? introductionDto;

  StreamSubscription? _loadIntroductionSub;

  @override
  void initState() {
    super.initState();
    final LoadCityIntroductionService loadIntroductionService =
        Provider.of<LoadCityIntroductionService>(context, listen: false);

    _loadIntroductionSub = loadIntroductionService.load$(widget.city).listen(
      (cityIntroductionDto) {
        if (mounted) {
          setState(() {
            introductionDto = cityIntroductionDto;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadIntroductionSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final TextTheme textTheme = Theme.of(context).textTheme;
    final double sidePadding = size.width * 0.08;

    return Scaffold2222.city(
      city: widget.city,
      // ignore: prefer_const_literals_to_create_immutables
      backgrounds: [BackgroundDecorationStyle.bottomRight],
      route: CityIntroductionScreen.route,
      body: ListView(
        children: [
          /// app logo
          const Padding(
            padding: EdgeInsets.only(bottom: 40),
            child: LogosHeader(
              showAppLogo: true,
            ),
          ),

          /// Texto cambiar por funcionalidad de cuenta de días
          Padding(
            padding: EdgeInsets.only(
              bottom: 20,
              left: sidePadding,
              right: sidePadding,
            ),
            child: Text(
              widget.city.phaseName,
              textAlign: TextAlign.center,
              style: textTheme.headline5,
            ),
          ),

          /// city name with hero functionality, apply no underline style to prevent
          /// yellow underline on transition
          Padding(
            padding: EdgeInsets.only(
              bottom: 16,
              left: sidePadding,
              right: sidePadding,
            ),
            child: Text(
              widget.city.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: textTheme.headline3,
            ),
          ),

          /// city logo
          /// since image is in a 1 to 1 aspect ratio make height and width the same
          Padding(
            padding: EdgeInsets.only(
              bottom: 40,
              left: sidePadding,
              right: sidePadding,
            ),
            child: Hero(
              tag: widget.city.icon.path,
              child: Image(
                width: size.height * 0.25,
                height: size.height * 0.25,
                image: widget.city.iconImage,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),

          /// loading screen or content
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
            child: (introductionDto == null)
                ? const AppLoading()
                : Markdown2222(
                    data: introductionDto!.description,
                    contentAlignment: WrapAlignment.center,
                  ),
          )
        ],
      ),
    );
  }
}

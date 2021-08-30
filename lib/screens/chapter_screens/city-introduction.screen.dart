import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city-introduction.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-city-introduction.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';

class CityIntroductionScreen extends StatefulWidget {
  static const String route = '/introduction';

  final CityDto city;

  final ILoadOptions<CityIntroductionDto, CityDto> introductionLoader;

  CityIntroductionScreen({
    Key? key,
    required CityDto city,
  })  : this.city = city,
        this.introductionLoader = LoadCityIntroductionService(city: city),
        super(key: key);

  @override
  _CityIntroductionScreenState createState() => _CityIntroductionScreenState();
}

class _CityIntroductionScreenState extends State<CityIntroductionScreen> {
  CityIntroductionDto? introductionDto;

  @override
  void initState() {
    this
        .widget
        .introductionLoader
        .load()
        .then((value) => this.setState(() => this.introductionDto = value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final TextTheme textTheme = Theme.of(context).textTheme;
    final double sidePadding = size.width * 0.08;

    return Scaffold2222(
      city: this.widget.city,
      backgrounds: [BackgroundDecorationStyle.bottomRight],
      route: CityIntroductionScreen.route,
      body: ListView(
        children: [
          /// app logo
          Padding(
            padding: EdgeInsets.only(bottom: 64),
            child: LogosHeader(
              showAppLogo: true,
              showStageLogoCity: widget.city,
            ),
          ),

          /// Texto cambiar por funcionalidad de cuenta de días
          Padding(
            padding: EdgeInsets.only(
              bottom: 16,
              left: sidePadding,
              right: sidePadding,
            ),
            child: Text(
              this.widget.city.phaseName,
              textAlign: TextAlign.center,
              style: textTheme.headline5,
            ),
          ),

          /// city name with hero functionality, apply no underline style to prevent
          /// yellow underline on transition
          Padding(
            padding: EdgeInsets.only(
              bottom: 8,
              left: sidePadding,
              right: sidePadding,
            ),
            child: Text(
              this.widget.city.name.toUpperCase(),
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
              tag: this.widget.city.icon.path,
              child: Image(
                width: size.height * 0.25,
                height: size.height * 0.25,
                image: this.widget.city.iconImage,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),

          /// loading screen or content
          Padding(
            padding: EdgeInsets.fromLTRB(sidePadding, 0, sidePadding, 20),
            child: (this.introductionDto == null)
                ? AppLoading()
                : Markdown2222(
                    data: this.introductionDto!.description,
                    contentAlignment: WrapAlignment.center,
                  ),
          )
        ],
      ),
    );
  }
}

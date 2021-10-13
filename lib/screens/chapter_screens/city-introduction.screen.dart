import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/models/city-introduction.dto.dart';
import 'package:lab_movil_2222/services/load-city-introduction.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/keys/keysToBeInheritedProvider.service.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/header-logos.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';
import 'package:showcaseview/showcaseview.dart';

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
      backgrounds: const [BackgroundDecorationStyle.bottomRight],
      route: CityIntroductionScreen.route,
      body: _CityIntroductionBody(
          sidePadding: sidePadding,
          textTheme: textTheme,
          size: size,
          city: widget.city,
          introductionDto: introductionDto),
    );
  }
}

class _CityIntroductionBody extends StatefulWidget {
  const _CityIntroductionBody(
      {Key? key,
      required this.sidePadding,
      required this.textTheme,
      required this.size,
      required this.introductionDto,
      required this.city})
      : super(key: key);

  final double sidePadding;
  final CityModel city;
  final TextTheme textTheme;
  final Size size;
  final CityIntroductionDto? introductionDto;

  @override
  State<_CityIntroductionBody> createState() => _CityIntroductionBodyState();
}

class _CityIntroductionBodyState extends State<_CityIntroductionBody> {
  late final KeysToBeInheritedProvider? keysProvider;

  @override
  void initState() {
    super.initState();

    keysProvider =
        Provider.of<KeysToBeInheritedProvider>(context, listen: false);
    if (keysProvider!.showUserGuide!) {
      /// starts the user guide when the page renders
      WidgetsBinding.instance!.addPostFrameCallback((_) async {
        ShowCaseWidget.of(context)!.startShowCase([
          /// the keys of the widgets to be showed
          /// leftArrowIconKey references to the horizontal drag
          keysProvider!.leftArrowIconKey,
        ]);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
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
            left: widget.sidePadding,
            right: widget.sidePadding,
          ),
          child: Text(
            widget.city.phaseName,
            textAlign: TextAlign.center,
            style: widget.textTheme.headline5,
          ),
        ),

        /// city name with hero functionality, apply no underline style to prevent
        /// yellow underline on transition
        Padding(
          padding: EdgeInsets.only(
            bottom: 16,
            left: widget.sidePadding,
            right: widget.sidePadding,
          ),
          child: Text(
            widget.city.name.toUpperCase(),
            textAlign: TextAlign.center,
            style: widget.textTheme.headline3,
          ),
        ),

        /// city logo
        /// since image is in a 1 to 1 aspect ratio make height and width the same
        Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: 40,
                left: widget.sidePadding,
                right: widget.sidePadding,
              ),
              child: Hero(
                tag: widget.city.icon.path,
                child: Image(
                  width: widget.size.height * 0.25,
                  height: widget.size.height * 0.25,
                  image: widget.city.iconImage,
                  filterQuality: FilterQuality.high,
                ),
              ),
            ),
            Showcase(
              key: keysProvider!.leftArrowIconKey,
              description:
                  'Puedes deslizar hacia la derecha o izquierda para navegar en la ciudad.',
              onTargetClick: () {
                setState(() {
                  keysProvider!.showUserGuide = false;
                });
              },
              onToolTipClick: () {
                setState(() {
                  keysProvider!.showUserGuide = false;
                });
              },
              disposeOnTap: true,
              child: (keysProvider!.showUserGuide!)
                  ? Center(
                      child: Container(
                        height: 200,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: const <Icon>[
                            Icon(
                              Icons.chevron_left,
                              size: 80,
                            ),
                            Icon(Icons.chevron_right, size: 80)
                          ],
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        ),
                      ),
                    )
                  : Container(),
            ),
          ],
        ),

        /// loading screen or content
        Padding(
          padding: EdgeInsets.fromLTRB(
              widget.sidePadding, 0, widget.sidePadding, 20),
          child: (widget.introductionDto == null)
              ? const AppLoading()
              : Markdown2222(
                  data: widget.introductionDto!.description,
                  contentAlignment: WrapAlignment.center,
                ),
        ),
      ],
    );
  }
}

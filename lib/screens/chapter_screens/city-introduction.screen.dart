import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-with-options.service.dart';
import 'package:lab_movil_2222/models/city-introduction.dto.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';
import 'package:lab_movil_2222/services/load-city-introduction.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter-head-banner_widget.dart';
import 'package:lab_movil_2222/shared/widgets/chapter_background_widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';

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
    VoidCallback prevPage = () => Navigator.pop(context);
    VoidCallback nextPage = () => Navigator.pushNamed(
          context,
          StageHistoryScreen.route,
          arguments: StageHistoryScreen(
            city: this.widget.city,
          ),
        );

    // Navigator.pushNamed(context, StageIntroductionScreen.route);

    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onPanUpdate: (details) {
          /// left
          if (details.delta.dx > 5) prevPage();

          /// right
          if (details.delta.dx < -5) nextPage();
        },

        /// main content of page
        /// the content includes a background with images, and scroll-able content
        child: Stack(
          alignment: Alignment.center,
          children: [
            /// first layer is the background with road-map
            ChapterBackgroundWidget(
              backgroundColor: widget.city.color,
              reliefPosition: 'bottom-right',
            ),

            /// scroll-able content
            _introductionBody(size, context),
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(
        nextPage: nextPage,
        prevPage: prevPage,
      ),
    );
  }

  _introductionBody(Size size, BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final double sidePadding = size.width * 0.08;
    //Creando el Scroll
    double spacedSize = size.height * 0.08;
    double fontSize = (size.height > 700) ? 1.2 : 1.1;
    double bodyMarginLeft = size.width * 0.05;
    if (size.height < 550) {
      spacedSize = size.height * 0.15;
    }
    if (size.height < 650) {
      spacedSize = size.height * 0.08;
    }

    return ListView(
      children: [
        /// app logo
        Padding(
          padding: EdgeInsets.only(bottom: spacedSize),
          child: ChapterHeadWidget(
            showAppLogo: true,
            city: widget.city,
          ),
        ),

        /// Texto cambiar por funcionalidad de cuenta de días
        Padding(
          padding: EdgeInsets.only(
            bottom: 16,
            left: sidePadding,
            right: sidePadding,
          ),
          child: Hero(
            tag: this.widget.city.phaseTag,
            child: Text(
              this.widget.city.phaseName,
              textAlign: TextAlign.center,
              style: textTheme.headline5,
            ),
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
          child: Hero(
            tag: this.widget.city.nameTag,
            child: Text(
              this.widget.city.name.toUpperCase(),
              textAlign: TextAlign.center,
              style: textTheme.headline3,
            ),
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
    );
  }
}

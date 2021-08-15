import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/city-with-map-position.model.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/services/load-cities-with-map-position.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

import 'chapter_screens/city-introduction.screen.dart';
import 'welcome.screen.dart';

class HomeScreen extends StatefulWidget {
  static const String route = '/';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// all cities positions loader
  final ILoadInformationService<List<CityWithMapPositionDto>> allCitiesLoader =
      LoadCitiesWithMapPositionService();

  /// list of cities with their position in the map
  List<CityWithMapPositionDto>? cities;

  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    this.allCitiesLoader.load().then((cities) {
      this.setState(() => this.cities = cities);

      /// once all cities have loaded make map scroll automatically
      Timer(
        Duration(seconds: 1),
        () {
          try {
            this.scrollController.animateTo(
                  this.scrollController.position.maxScrollExtent,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 500),
                );
          } catch (e) {}
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(
        homeAction: () => Navigator.pushNamed(
          context,
          WelcomeScreen.route,
        ),
      ),
      body: (this.cities == null)

          /// if cities data is still loading, replace everything this a loading text
          ? Center(
              child: AppLoading(),
            )

          /// otherwise load the map with cities
          : SafeArea(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  controller: this.scrollController,
                  child: _CitiesScrollMap(
                    citiesWithPositions:
                        this.cities as List<CityWithMapPositionDto>,
                  ),
                ),
              ),
            ),
    );
  }
}

class _CitiesScrollMap extends StatelessWidget {
  _CitiesScrollMap({
    Key? key,
    required this.citiesWithPositions,
  }) : super(key: key);

  /// items to be displayed on top of map
  final List<CityWithMapPositionDto> citiesWithPositions;

  /// default map image used by the app
  final ImageProvider mapImage =
      AssetImage('assets/images/map-with-no-icons.png');

  @override
  Widget build(BuildContext context) {
    /// used stack to place map behind items, and place a container of items on top
    /// of the map
    return Stack(
      children: [
        /// map image in this context is used as a background
        Image(
          image: this.mapImage,
          fit: BoxFit.fill,
          width: double.infinity,
        ),

        /// overlay of items on top of map
        /// use a positioned fill to make it take all space available, then
        /// use a layout builder to access map image size, and position items
        /// relative to the map, without distortion
        Positioned.fill(
          child: LayoutBuilder(
            builder: (context, constraints) {
              /// obtain referential space units to place items
              /// when the width changes make the items on top space at the same pace
              final double vw = constraints.biggest.width / 100;
              final double vh = constraints.biggest.height / 100;

              return Stack(
                children: [
                  /// draw all cities with positions
                  for (CityWithMapPositionDto cityPos
                      in this.citiesWithPositions)
                    Positioned(
                      top: cityPos.top * vh,
                      left: cityPos.left * vw,
                      child: _MapCityButton(
                        city: cityPos.city,
                        size: cityPos.size * vw,
                        textOnTop: cityPos.textOnTop,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}

class _MapCityButton extends StatelessWidget {
  final CityDto city;
  final double size;
  final bool textOnTop;

  const _MapCityButton({
    Key? key,
    required this.city,
    required this.size,
    required this.textOnTop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size fontFactor = MediaQuery.of(context).size;
    final bool smallFont = fontFactor.width < 750;

    return Container(
      width: this.size,
      height: this.size,
      child: Stack(
        clipBehavior: Clip.none,

        /// make text go on top of image by placing it on top of image container
        children: [
          /// placeholder color
          Positioned.fill(
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.all(Radius.circular(this.size)),
              child: Container(
                color: Colors2222.mapColor,
              ),
            ),
          ),

          /// position the image first so the inkwell effect stay on top
          Positioned.fill(
            child: ClipRRect(
              clipBehavior: Clip.hardEdge,
              borderRadius: BorderRadius.all(Radius.circular(this.size)),
              child: Image(
                image: this.city.iconMapImage,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
          ),

          /// inkwell with on press gesture detector, with a clip on top so it stays
          /// in a circular shape
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(this.size)),
              clipBehavior: Clip.hardEdge,
              child: InkWell(
                splashColor: this.city.color.withOpacity(0.5),
                onTap: () => Navigator.pushNamed(
                  context,
                  CityIntroductionScreen.route,
                  arguments: CityIntroductionScreen(
                    city: city,
                  ),
                ),
                child: Container(),
              ),
            ),
          ),

          /// city name with the city number, to position the item bellow or
          /// on top of the main image, we use the size of the container, plus 8 units
          /// for spacing
          Positioned(
            top: !this.textOnTop ? this.size + (smallFont ? 4 : 8) : null,
            bottom: this.textOnTop ? this.size + (smallFont ? 4 : 8) : null,
            left: -this.size,
            right: -this.size,
            child: Center(
              child: Text(
                '${this.city.stage} ${this.city.name.toUpperCase()}',
                style:
                    smallFont ? korolevFont.bodyText2 : korolevFont.headline5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/services/i-load-information.service.dart';
import 'package:lab_movil_2222/services/load-cities-with-map-position.service.dart';
import 'package:lab_movil_2222/shared/models/city-with-map-position.model.dart';
import 'package:lab_movil_2222/shared/models/city.dto.dart';
import 'package:lab_movil_2222/shared/widgets/custom_navigation_bar.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';

import 'chapter_screens/stageIntroduction.screen.dart';

class CitiesMapScreen extends StatefulWidget {
  static const String route = '/cities-map';

  @override
  _CitiesMapScreenState createState() => _CitiesMapScreenState();
}

class _CitiesMapScreenState extends State<CitiesMapScreen> {
  List<CityWithMapPositionDto>? cities;

  final ILoadInformationService<List<CityWithMapPositionDto>> allCitiesLoader =
      LoadCitiesWithMapPositionService();

  final ScrollController scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

    this.allCitiesLoader.load().then((cities) {
      this.setState(() {
        this.cities = cities;
      });

      /// once all cities have loaded make map scroll automatically
      Timer(
        Duration(seconds: 1),
        () => this.scrollController.animateTo(
              this.scrollController.position.maxScrollExtent,
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 500),
            ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomNavigationBar(),
      body: (this.cities == null)

          /// if cities data is still loading, replace everything this a loading text
          ? Center(
              child: Text(
                'Cargando...',
                style: korolevFont.bodyText1,
              ),
            )

          /// otherwise load coll map with cities
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
              
                controller: this.scrollController,
                child: CitiesScrollMap(
                  cities: this.cities as List<CityWithMapPositionDto>,
                ),
              ),
            ),
    );
  }
}

class CitiesScrollMap extends StatelessWidget {
  CitiesScrollMap({
    Key? key,
    required this.cities,
  }) : super(key: key);

  final List<CityWithMapPositionDto> cities;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        /// map image
        Image.asset(
          'assets/images/map_wip.png',
          fit: BoxFit.fill,
          width: double.infinity,
        ),

        /// overlay of items on top of map
        Positioned.fill(child: LayoutBuilder(builder: (context, constraints) {
          final double vw = constraints.biggest.width / 100;
          final double vh = constraints.biggest.height / 100;

          return Stack(
            children: [
              /// draw all cities with positions
              for (CityWithMapPositionDto cityPos in this.cities)
                MapCityButton(
                  city: cityPos.city,
                  size: cityPos.size * vw,
                  x: cityPos.left * vw,
                  y: cityPos.top * vh,
                )
            ],
          );
        })),
      ],
    );
  }
}

class MapCityButton extends StatelessWidget {
  final CityDto city;
  final double positionX;
  final double positionY;
  final double size;

  const MapCityButton({
    Key? key,
    required this.city,
    required this.size,
    required double x,
    required double y,
  })  : this.positionX = x,
        this.positionY = y,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: this.positionY,
      left: this.positionX,
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(this.size)),
        color: Colors.transparent,
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            StageIntroductionScreen.route,
            arguments: StageIntroductionScreen(
              chapterSettings: city,
            ),
          ),
          child: Container(
            width: this.size,
            height: this.size,
          ),
        ),
      ),
    );
  }
}

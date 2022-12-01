import 'package:flutter/material.dart';
import 'package:lab_movil_2222/home-map/models/city-with-map-position.model.dart';
import 'package:lab_movil_2222/home-map/ui/widgets/city-map-button.dart';
import 'package:lab_movil_2222/shared/widgets/fade-in-delayed.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class CitiesMap extends StatelessWidget {
  const CitiesMap({
    Key? key,
    required this.citiesWithPositions,
  }) : super(key: key);

  /// items to be displayed on top of map
  final List<CityWithMapPositionModel> citiesWithPositions;

  @override
  Widget build(BuildContext context) {
    /// used stack to place map behind items, and place a container of items on top
    /// of the map
    return Stack(
      children: [
        /// set top and bottom one pixel inside, so that it doesn't
        /// have a black line at the end of the map
        Positioned.fill(
          bottom: 1,
          top: 1,
          child: Container(color: Colors2222.black),
        ),

        /// map image in this context is used as a background
        const Image(
          image: AssetImage('assets/images/map.png'),
          fit: BoxFit.fill,
          width: double.infinity,
        ),

        /// animate path appearance
        /// durations is calculated by taking time of the cities to apear and then apear the path
        Positioned.fill(
          child: FadeInDelayed(
            delay:
                Duration(milliseconds: citiesWithPositions.length * 100 + 800),
            child: const Image(
              image: AssetImage('assets/images/map_path.png'),
              fit: BoxFit.fill,
              width: double.infinity,
            ),
          ),
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
                  for (int i = 0; i < citiesWithPositions.length; i++)
                    Positioned(
                      top: citiesWithPositions[i].top * vh,
                      left: citiesWithPositions[i].left * vw,
                      child: CityMapButton(
                        city: citiesWithPositions[i].city,
                        size: citiesWithPositions[i].size * vw,
                        textOnTop: citiesWithPositions[i].textOnTop,
                        fadeInDelay:
                            Duration(milliseconds: 100 * (i + 1) + 500),
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

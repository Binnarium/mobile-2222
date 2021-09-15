import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city-with-map-position.model.dart';
import 'package:lab_movil_2222/city/ui/widgets/city-map-button.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class CitiesMap extends StatelessWidget {
  CitiesMap({
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
          child: Container(color: Colors2222.black),
          bottom: 1,
          top: 1,
        ),

        /// map image in this context is used as a background
        const Image(
          image: const AssetImage('assets/images/map-with-no-icons.png'),
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
                  for (CityWithMapPositionModel cityPos
                      in this.citiesWithPositions)
                    Positioned(
                      top: cityPos.top * vh,
                      left: cityPos.left * vw,
                      child: CityMapButton(
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

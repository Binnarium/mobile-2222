import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/home-map/models/city-with-map-position.model.dart';
import 'package:lab_movil_2222/home-map/services/load-cities-with-map-position.service.dart';
import 'package:lab_movil_2222/home-map/ui/widgets/cities-map.dart';
import 'package:lab_movil_2222/home-map/ui/widgets/home-background.dart';
import 'package:lab_movil_2222/home-map/ui/widgets/workshop-button.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/fade-in-delayed.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/bottom-navigation-bar-widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

/// flag to enable or disable auto scroll on page load
const bool enableAutoScroll = false;

/// main screen of the app to navigate any city or content
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static String get route => '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// all cities positions loader
  CitiesMapPositionsService get _allCitiesLoader =>
      Provider.of<CitiesMapPositionsService>(context, listen: false);

  /// list of cities with their position in the map
  List<CityWithMapPositionModel>? _cities;

  final ScrollController _scrollController = ScrollController();

  StreamSubscription? _citiesSub;

  @override
  void initState() {
    super.initState();

    _citiesSub = _allCitiesLoader.load$.listen((cities) {
      setState(() => _cities = cities);

      /// once all cities have loaded make map scroll automatically
      /// if flag has been enabled
      if (enableAutoScroll) {
        Timer(const Duration(microseconds: 0), _scrollMapBottom);
      }
    });
  }

  @override
  void dispose() {
    _citiesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold2222.navigation(
      backgroundColor: Colors2222.black,
      activePage: Lab2222NavigationBarPages.home,
      body: (_cities == null)

          /// if cities data is still loading, replace everything this a loading text
          ? const Center(
              child: AppLoading(),
            )

          /// otherwise load the map with cities
          : FadeInDelayed(
              delay: const Duration(milliseconds: 200),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: Stack(
                  children: [
                    /// background content to fill whitespace
                    HomeBackground(),

                    /// scroll content
                    ListView(
                        clipBehavior: Clip.none,
                        controller: _scrollController,
                        children: [
                          /// button
                          Container(
                            padding: EdgeInsets.only(
                              top: 40,
                              left: size.width * .04,
                              right: size.width * .04,
                            ),
                            alignment: Alignment.center,
                            child: const WorkshopMapButton(),
                          ),

                          /// cities map
                          Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: CitiesMap(citiesWithPositions: _cities!),
                          )
                        ]),
                  ],
                ),
              ),
            ),
    );
  }

  /// make listView scroll to bottom
  void _scrollMapBottom() {
    try {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        curve: Curves.ease,
        duration: const Duration(milliseconds: 500),
      );
    } catch (e) {
      print(e);
    }
  }
}

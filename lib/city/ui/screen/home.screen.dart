import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city-with-map-position.model.dart';
import 'package:lab_movil_2222/city/services/load-cities-with-map-position.service.dart';
import 'package:lab_movil_2222/city/ui/widgets/cities-map.dart';
import 'package:lab_movil_2222/city/ui/widgets/home-background.dart';
import 'package:lab_movil_2222/player/services/get-current-player.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/bottom-navigation-bar-widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

/// flag to enable or disable auto scroll on page load
const bool enableAutoScroll = false;

/// main screen of the app to navigate any city or content
// ignore: use_key_in_widget_constructors
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

  CurrentPlayerService get _currentPlayerLoader =>
      Provider.of<CurrentPlayerService>(context, listen: false);

  /// list of cities with their position in the map
  List<CityWithMapPositionModel>? _cities;

  final ScrollController _scrollController = ScrollController();

  StreamSubscription? _citiesSub;
  StreamSubscription? _currentPlayerSub;

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

    _currentPlayerSub = _currentPlayerLoader.player$.listen((event) {
      print(event?.courseStatus);
    });
  }

  @override
  void dispose() {
    _citiesSub?.cancel();
    _currentPlayerSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.navigation(
      activePage: Lab2222NavigationBarPages.home,
      body: (_cities == null)

          /// if cities data is still loading, replace everything this a loading text
          ? const Center(
              child: AppLoading(),
            )

          /// otherwise load the map with cities
          : SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  /// background content to fill whitespace
                  HomeBackground(),

                  /// scroll content
                  SingleChildScrollView(
                    clipBehavior: Clip.none,
                    controller: _scrollController,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 32.0),
                      child: CitiesMap(citiesWithPositions: _cities!),
                    ),
                  ),
                ],
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

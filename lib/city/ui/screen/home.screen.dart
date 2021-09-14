import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/services/load-cities-with-map-position.service.dart';
import 'package:lab_movil_2222/city/ui/widgets/cities-map.dart';
import 'package:lab_movil_2222/city/ui/widgets/home-background.dart';
import 'package:lab_movil_2222/models/city-with-map-position.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/bottom-navigation-bar-widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

/// flag to enable or disable auto scroll on page load
const bool _ENABLE_AUTO_SCROLL = false;

class HomeScreen extends StatefulWidget {
  static const String route = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /// all cities positions loader
  CitiesMapPositionsService get _allCitiesLoader =>
      Provider.of<CitiesMapPositionsService>(context);

  /// list of cities with their position in the map
  List<CityWithMapPositionDto>? _cities;

  final ScrollController _scrollController = ScrollController();

  StreamSubscription? _citiesSub;

  @override
  void initState() {
    super.initState();

    this._citiesSub = this._allCitiesLoader.load$.listen((cities) {
      this.setState(() => this._cities = cities);

      /// once all cities have loaded make map scroll automatically
      /// if flag has been enabled
      if (_ENABLE_AUTO_SCROLL)
        Timer(Duration(microseconds: 0), this._scrollMapBottom);
    });
  }

  @override
  void dispose() {
    this._citiesSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold2222.navigation(
      activePage: Lab2222NavigationBarPages.home,
      body: (this._cities == null)

          /// if cities data is still loading, replace everything this a loading text
          ? Center(
              child: AppLoading(),
            )

          /// otherwise load the map with cities
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                children: [
                  /// background content to fill whitespace
                  HomeBackground(),

                  /// scroll content
                  SingleChildScrollView(
                    clipBehavior: Clip.none,
                    controller: this._scrollController,
                    child: CitiesMap(
                      citiesWithPositions: this._cities!,
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
      this._scrollController.animateTo(
            this._scrollController.position.maxScrollExtent,
            curve: Curves.ease,
            duration: const Duration(milliseconds: 500),
          );
    } catch (e) {}
  }
}

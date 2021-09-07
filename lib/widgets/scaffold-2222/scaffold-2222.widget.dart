import 'package:flutter/material.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/cities-navigation.service.dart';

import 'bottom-navigation-bar-widget.dart';

class Scaffold2222 extends StatelessWidget {
  @Deprecated('use a proper constructor instead')
  Scaffold2222({
    Key? key,
    required this.body,
    required CityDto city,
    required String route,
    this.backgrounds = const [],
  })  : this._nextRoute = CityNavigator.getNextPage(route, city),
        this._showBottomNavigationBar = true,
        this.appBar = null,
        this._backgroundColor = city.color,
        this.backButton = true,
        this.activePage = null,
        super(key: key);

  /// scaffold for cities with right and left navigation buttons
  Scaffold2222.city({
    Key? key,
    required this.body,
    required CityDto city,
    required String route,
    Color? color,
    this.backgrounds = const [],
  })  : this._nextRoute = CityNavigator.getNextPage(route, city),
        this._showBottomNavigationBar = true,
        this.backButton = true,
        this._backgroundColor = color ?? city.color,
        this.appBar = null,
        this.activePage = null,
        super(key: key);

  /// modifiers scaffold to include background decorations of the lab movil 2222
  Scaffold2222.empty({
    Key? key,
    required this.body,
    Color backgroundColor = Colors2222.red,
    this.appBar,
    this.backgrounds = const [],
  })  : this._nextRoute = null,
        this.backButton = false,
        this._showBottomNavigationBar = false,
        this._backgroundColor = backgroundColor,
        this.activePage = null,
        super(key: key);

  /// scaffold with bottom bar navigation, but no navigate right or left button
  Scaffold2222.navigation({
    Key? key,
    required this.body,
    this.backgrounds = const [],
    this.backButton = false,
    this.appBar,
    required this.activePage,
  })  : this._nextRoute = null,
        this._showBottomNavigationBar = true,
        this._backgroundColor = Colors2222.red,
        super(key: key);

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// content of the scaffold
  final Widget body;

  /// background decorators
  final List<BackgroundDecorationStyle> backgrounds;

  /// navigator next route
  final ScaffoldRouteBuilder? _nextRoute;

  /// enable back button
  final bool backButton;

  /// enable bottom navbar
  final bool _showBottomNavigationBar;

  /// set a background color for the scaffold
  final Color _backgroundColor;

  /// decorator to set a navigation item to an active state
  final Lab2222NavigationBarPages? activePage;

  @override
  Widget build(BuildContext context) {
    /// back button
    VoidCallback? prevPage = backButton ? () => Navigator.pop(context) : null;

    /// next page button
    VoidCallback? nextPage = this._nextRoute == null
        ? null
        : () => this._nextRoute!.builder(context);

    /// page layout
    return Scaffold(
      backgroundColor: this._backgroundColor,

      /// add bottom navigation if enabled
      bottomNavigationBar: (this._showBottomNavigationBar)
          ? Lab2222BottomNavigationBar(
              nextPage: nextPage,
              prevPage: prevPage,
              activePage: activePage,
            )
          : null,

      appBar: this.appBar,

      /// wrap everything in a gesture detector to move across cities
      body: GestureDetector(
        onPanUpdate: (details) {
          /// left
          if (prevPage != null && details.delta.dx > 5) prevPage();

          /// right
          if (nextPage != null && details.delta.dx < -5) nextPage();
        },
        child: BackgroundDecoration(
          backgroundDecorationsStyles: backgrounds,
          child: SafeArea(
            top: this.appBar == null,
            child: body,
            bottom: !this._showBottomNavigationBar,
          ),
        ),
      ),
    );
  }
}

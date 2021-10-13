import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/cities-navigation.service.dart';
import 'package:showcaseview/showcaseview.dart';

import 'bottom-navigation-bar-widget.dart';

class Scaffold2222 extends StatefulWidget {
  @Deprecated('use a proper constructor instead')
  Scaffold2222({
    Key? key,
    required this.body,
    required CityModel city,
    required String route,
    this.backgrounds = const [],
  })  : _nextRoute = CityNavigator.getNextPage(route, city),
        _showBottomNavigationBar = true,
        _enableBack = true,
        appBar = null,
        _backgroundColor = city.color,
        activePage = null,
        super(key: key);

  /// scaffold for cities with right and left navigation buttons
  Scaffold2222.city({
    Key? key,
    required this.body,
    required CityModel city,
    required String route,
    Color? color,
    this.backgrounds = const [],
  })  : _nextRoute = CityNavigator.getNextPage(route, city),
        _enableBack = true,
        _showBottomNavigationBar = true,
        _backgroundColor = color ?? city.color,
        appBar = null,
        activePage = null,
        super(key: key);

  /// modifiers scaffold to include background decorations of the lab movil 2222
  const Scaffold2222.empty({
    Key? key,
    required this.body,
    Color backgroundColor = Colors2222.red,
    this.appBar,
    this.backgrounds = const [],
  })  : _nextRoute = null,
        _showBottomNavigationBar = false,
        _enableBack = false,
        _backgroundColor = backgroundColor,
        activePage = null,
        super(key: key);

  /// scaffold with bottom bar navigation, but no navigate right or left button
  const Scaffold2222.navigation({
    Key? key,
    required this.body,
    this.backgrounds = const [],
    this.appBar,
    required this.activePage,
    Color? backgroundColor,
  })  : _nextRoute = null,
        _showBottomNavigationBar = true,
        _enableBack = true,
        _backgroundColor = backgroundColor ?? Colors2222.red,
        super(key: key);

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  /// content of the scaffold
  final Widget body;

  /// background decorators
  final List<BackgroundDecorationStyle> backgrounds;

  /// navigator next route
  final ScaffoldRouteBuilder? _nextRoute;

  /// enable back button and gestures
  final bool _enableBack;

  /// enable bottom navbar
  final bool _showBottomNavigationBar;

  /// set a background color for the scaffold
  final Color _backgroundColor;

  /// decorator to set a navigation item to an active state
  final Lab2222NavigationBarPages? activePage;

  @override
  State<Scaffold2222> createState() => _Scaffold2222State();
}

class _Scaffold2222State extends State<Scaffold2222> {
  @override
  Widget build(BuildContext context) {
    /// next page button
    final VoidCallback? prevPage =
        widget._enableBack && Navigator.of(context).canPop()
            ? () => Navigator.pop(context)
            : null;

    final VoidCallback? nextPage = widget._nextRoute == null
        ? null
        : () => widget._nextRoute!.builder(context);

    /// page layout
    return ShowCaseWidget(
      builder: Builder(
        builder: (context) => Scaffold(
          backgroundColor: widget._backgroundColor,

          /// add bottom navigation if enabled
          bottomNavigationBar: widget._showBottomNavigationBar
              ? Lab2222BottomNavigationBar(
                  nextPage: nextPage,
                  prevPage: prevPage,
                  activePage: widget.activePage,
                )
              : null,

          appBar: widget.appBar,

          /// wrap everything in a gesture detector to move across cities
          body: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onPanUpdate: (details) {
              /// left
              if (prevPage != null && details.delta.dx > 5) {
                prevPage();
              }

              /// right
              if (nextPage != null && details.delta.dx < -5) {
                nextPage();
              }
            },
            child: BackgroundDecoration(
              backgroundDecorationsStyles: widget.backgrounds,
              child: SafeArea(
                top: widget.appBar == null,
                bottom: !widget._showBottomNavigationBar,
                child: widget.body,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

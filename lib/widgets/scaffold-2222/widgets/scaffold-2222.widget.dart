import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:lab_movil_2222/city/models/city.dto.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/cities-navigation.service.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/services/connectivity-check.service.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/connectivity-snackbar.widget.dart';
import 'package:provider/provider.dart';

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
  /// connectivity subscription to listen whether the phone is connected
  StreamSubscription? _connectivitySub;

  /// default connectivity type
  ConnectivityResult? oldConnectivityresult = ConnectivityResult.none;

  /// provider of the connectivity check service
  late final ConnectivityCheckService conectivityProvider;

  @override
  void didChangeDependencies() {
    /// initialize the provider (needs to be on this method)
    conectivityProvider = Provider.of<ConnectivityCheckService>(context);
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    /// stream that listen the connectivity
    _connectivitySub = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult newConnection) {
      setState(() {
        print('NEVER SHOW AGAIN?: ${conectivityProvider.neverShowAgain}');

        /// if there is no connection this will appear
        if (newConnection == ConnectivityResult.none &&
            oldConnectivityresult != newConnection &&
            conectivityProvider.neverShowAgain == false) {
          /// shows the no connection snackbar
          ScaffoldMessenger.of(context)
              .showSnackBar(ConnectivityStatusSnackbar.none(context));

          /// if the phone reaches connection, it will enter in this block
        } else if (oldConnectivityresult == ConnectivityResult.none &&
            conectivityProvider.neverShowAgain == false) {
          /// shows the wifi  connection snackbar
          if (newConnection == ConnectivityResult.wifi &&
              conectivityProvider.neverShowAgain == false) {
            ScaffoldMessenger.of(context)
                .showSnackBar(ConnectivityStatusSnackbar.wifi(context));

            /// shows the mobile  connection snackbar
          } else if (newConnection == ConnectivityResult.mobile &&
              conectivityProvider.neverShowAgain == false) {
            ScaffoldMessenger.of(context)
                .showSnackBar(ConnectivityStatusSnackbar.mobile(context));
          }
        }

        /// reset the connection type to listen changes
        oldConnectivityresult = newConnection;
      });
    });
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    super.dispose();
  }

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
    return Scaffold(
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
    );
  }
}

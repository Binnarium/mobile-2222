import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/activity/widgets/activities.screen.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/clubhouse.screen.dart';
import 'package:lab_movil_2222/cities/final-video/widgets/final-video.screen.dart';
import 'package:lab_movil_2222/cities/manual-video/widgets/manual-video.screen.dart';
import 'package:lab_movil_2222/cities/project-video/widgets/project-video.screen.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-contribution.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-introduction.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-project.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/content.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/contribution.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/introductory-video.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/micro_meso_macro.screen..dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageArgumentation.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageMonster.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';

import 'bottom-navigation-bar-widget.dart';

class _ScaffoldRouteBuilder {
  final String route;
  final Future<void> Function(BuildContext) builder;

  _ScaffoldRouteBuilder({
    required this.route,
    required this.builder,
  });
}

class CityNavigator {
  static List<_ScaffoldRouteBuilder> _routes(
    CityEnabledPagesDto enabledPagesDto,
    CityDto city,
  ) =>
      [
        /// video introduction screen
        if (enabledPagesDto.introductoryVideo)
          _ScaffoldRouteBuilder(
            route: IntroductoryVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              IntroductoryVideoScreen.route,
              arguments: IntroductoryVideoScreen(
                city: city,
              ),
            ),
          ),

        /// introduction screen
        _ScaffoldRouteBuilder(
          route: CityIntroductionScreen.route,
          builder: (context) => Navigator.pushNamed(
            context,
            CityIntroductionScreen.route,
            arguments: CityIntroductionScreen(
              city: city,
            ),
          ),
        ),

        /// history screen
        _ScaffoldRouteBuilder(
          route: StageHistoryScreen.route,
          builder: (context) => Navigator.pushNamed(
            context,
            StageHistoryScreen.route,
            arguments: StageHistoryScreen(
              city: city,
            ),
          ),
        ),

        /// Monster screen
        _ScaffoldRouteBuilder(
          route: StageMonsterScreen.route,
          builder: (context) => Navigator.pushNamed(
            context,
            StageMonsterScreen.route,
            arguments: StageMonsterScreen(
              city: city,
            ),
          ),
        ),

        /// ideas
        if (enabledPagesDto.argumentation)
          _ScaffoldRouteBuilder(
            route: StageArgumentationScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              StageArgumentationScreen.route,
              arguments: StageArgumentationScreen(
                chapterSettings: city,
              ),
            ),
          ),

        /// objectives
        _ScaffoldRouteBuilder(
          route: StageObjetivesScreen.route,
          builder: (context) => Navigator.pushNamed(
            context,
            StageObjetivesScreen.route,
            arguments: StageObjetivesScreen(
              chapterSettings: city,
            ),
          ),
        ),

        /// content
        if (enabledPagesDto.content)
          _ScaffoldRouteBuilder(
            route: ContentScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ContentScreen.route,
              arguments: ContentScreen(
                city: city,
              ),
            ),
          ),

        /// resources
        if (enabledPagesDto.resources)
          _ScaffoldRouteBuilder(
            route: ResourcesScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ResourcesScreen.route,
              arguments: ResourcesScreen(
                city: city,
              ),
            ),
          ),

        if (enabledPagesDto.contribution)
          _ScaffoldRouteBuilder(
            route: ContributionScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ContributionScreen.route,
              arguments: ContributionScreen(
                city: city,
              ),
            ),
          ),

        /// activities
        if (enabledPagesDto.activities)
          _ScaffoldRouteBuilder(
            route: ActivitiesScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ActivitiesScreen.route,
              arguments: ActivitiesScreen(
                city: city,
              ),
            ),
          ),

        ///Contribution Screen

        ///Contribution
        if (enabledPagesDto.activities && enabledPagesDto.contribution)
          _ScaffoldRouteBuilder(
            route: YourContributionScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              YourContributionScreen.route,
              arguments: YourContributionScreen(
                city: city,
              ),
            ),
          ),

        /// clubhouse
        if (enabledPagesDto.activities && enabledPagesDto.clubhouse)
          _ScaffoldRouteBuilder(
            route: ClubhouseScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ClubhouseScreen.route,
              arguments: ClubhouseScreen(
                city: city,
              ),
            ),
          ),

        /// project
        if (enabledPagesDto.activities && enabledPagesDto.project)
          _ScaffoldRouteBuilder(
            route: CityProjectScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              CityProjectScreen.route,
              arguments: CityProjectScreen(
                city: city,
              ),
            ),
          ),

        /// project video
        if (enabledPagesDto.projectVideo)
          _ScaffoldRouteBuilder(
            route: ProjectVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ProjectVideoScreen.route,
              arguments: ProjectVideoScreen(
                city: city,
              ),
            ),
          ),

        /// manual video
        if (enabledPagesDto.manualVideo)
          _ScaffoldRouteBuilder(
            route: ManualVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ManualVideoScreen.route,
              arguments: ManualVideoScreen(
                city: city,
              ),
            ),
          ),

        /// mcrso-meso-macro
        if (enabledPagesDto.microMesoMacro)
          _ScaffoldRouteBuilder(
            route: MicroMesoMacroScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              MicroMesoMacroScreen.route,
              arguments: MicroMesoMacroScreen(
                city: city,
              ),
            ),
          ),
        if (enabledPagesDto.finalVideo)
          _ScaffoldRouteBuilder(
            route: FinalVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              FinalVideoScreen.route,
              arguments: FinalVideoScreen(
                city: city,
              ),
            ),
          ),
      ];

  ///
  static _ScaffoldRouteBuilder? getNextPage(
      String currentRoute, CityDto cityDto) {
    final List<_ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._routes(cityDto.enabledPages, cityDto);

    final int currentIndex =
        availableRoutes.indexWhere((element) => element.route == currentRoute);
    final int nextIndex = currentIndex + 1;

    /// if next index still inside array length then retrieve next page value
    /// otherwise send first item index with next city data
    if (nextIndex < availableRoutes.length) return availableRoutes[nextIndex];

    /// otherwise send to start of next city, if a next city exists
    if (cityDto.nextCity != null && nextIndex == availableRoutes.length) {
      final List<_ScaffoldRouteBuilder> nextCityRoutes =
          CityNavigator._routes(cityDto.enabledPages, cityDto.nextCity!);
      return nextCityRoutes[0];
    }

    return null;
  }

  static _ScaffoldRouteBuilder getFirsScreen(CityDto cityDto) {
    final List<_ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._routes(cityDto.enabledPages, cityDto);

    return availableRoutes[0];
  }
}

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
        this._backButton = true,
        this.activePage = null,
        super(key: key);

  Scaffold2222.city({
    Key? key,
    required this.body,
    required CityDto city,
    required String route,
    Color? color,
    this.backgrounds = const [],
  })  : this._nextRoute = CityNavigator.getNextPage(route, city),
        this._showBottomNavigationBar = true,
        this._backButton = true,
        this._backgroundColor = color ?? city.color,
        this.appBar = null,
        this.activePage = null,
        super(key: key);

  Scaffold2222.empty({
    Key? key,
    required this.body,
    Color backgroundColor = Colors2222.red,
    this.appBar,
    this.backgrounds = const [],
  })  : this._nextRoute = null,
        this._backButton = false,
        this._showBottomNavigationBar = false,
        this._backgroundColor = backgroundColor,
        this.activePage = null,
        super(key: key);

  Scaffold2222.navigation({
    Key? key,
    required this.body,
    this.backgrounds = const [],
    this.appBar,
    required this.activePage,
  })  : this._nextRoute = null,
        this._backButton = false,
        this._showBottomNavigationBar = true,
        this._backgroundColor = Colors2222.red,
        super(key: key);

  /// An app bar to display at the top of the scaffold.
  final PreferredSizeWidget? appBar;

  final Widget body;
  final List<BackgroundDecorationStyle> backgrounds;
  final _ScaffoldRouteBuilder? _nextRoute;
  final bool _backButton;
  final bool _showBottomNavigationBar;
  final Color _backgroundColor;
  final Lab2222NavigationBarPages? activePage;
  @override
  Widget build(BuildContext context) {
    /// back button
    VoidCallback? prevPage = _backButton ? () => Navigator.pop(context) : null;

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
          child: body,
        ),
      ),
    );
  }
}

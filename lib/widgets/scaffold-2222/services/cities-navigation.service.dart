import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/activity/widgets/activities.screen.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/clubhouse-explanation.screen.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/clubhouse.screen.dart';
import 'package:lab_movil_2222/cities/contribution/ui/screens/city-contribution.screen.dart';
import 'package:lab_movil_2222/cities/contribution/ui/screens/contribution-explanation.screen.dart';
import 'package:lab_movil_2222/cities/final-video/widgets/final-video.screen.dart';
import 'package:lab_movil_2222/cities/manual-video/widgets/manual-video.screen.dart';
import 'package:lab_movil_2222/cities/micro-meso-macro/ui/screens/micro-meso-macro.screen.dart';
import 'package:lab_movil_2222/cities/monster/ui/screens/stageMonster.screen.dart';
import 'package:lab_movil_2222/cities/project-video/widgets/project-video.screen.dart';
import 'package:lab_movil_2222/cities/project/ui/screens/project.screen.dart';
import 'package:lab_movil_2222/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-introduction.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-medals-hackaton.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/content.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/introductory-video.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageArgumentation.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';

class ScaffoldRouteBuilder {
  final String route;
  final Future<void> Function(BuildContext) builder;

  ScaffoldRouteBuilder({
    required this.route,
    required this.builder,
  });
}

class CityNavigator {
  /// get pages for the clubhouse
  static List<ScaffoldRouteBuilder> _clubhouseActivities(
    /// enabled pages configuration
    CityEnabledPagesDto enabledPagesDto,

    /// required city argument to load data
    CityDto city,
  ) =>
      [
        ///clubhouseExplanation
        if (enabledPagesDto.activities && enabledPagesDto.clubhouseExplanation)
          ScaffoldRouteBuilder(
            route: ClubhouseExplanationScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ClubhouseExplanationScreen.route,
              arguments: ClubhouseExplanationScreen(city: city),
            ),
          ),

        /// clubhouse
        if (enabledPagesDto.activities && enabledPagesDto.clubhouse)
          ScaffoldRouteBuilder(
            route: ClubhouseScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ClubhouseScreen.route,
              arguments: ClubhouseScreen(city: city),
            ),
          ),
      ];

  /// get pages for the clubhouse
  static List<ScaffoldRouteBuilder> _contributionActivities(
    /// enabled pages configuration
    CityEnabledPagesDto enabledPagesDto,

    /// required city argument to load data
    CityDto city,
  ) =>
      [
        ///Contribution
        if (enabledPagesDto.activities &&
            enabledPagesDto.contributionExplanation)
          ScaffoldRouteBuilder(
            route: ContributionExplanationScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ContributionExplanationScreen.route,
              arguments: ContributionExplanationScreen(city: city),
            ),
          ),

        ///Contribution
        if (enabledPagesDto.activities && enabledPagesDto.contribution)
          ScaffoldRouteBuilder(
            route: YourContributionScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              YourContributionScreen.route,
              arguments: YourContributionScreen(city: city),
            ),
          ),
      ];

  /// get pages for the clubhouse
  static List<ScaffoldRouteBuilder> _projectActivities(
    /// enabled pages configuration
    CityEnabledPagesDto enabledPagesDto,

    /// required city argument to load data
    CityDto city,
  ) =>
      [
        /// project video
        if (enabledPagesDto.projectVideo)
          ScaffoldRouteBuilder(
            route: ProjectVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ProjectVideoScreen.route,
              arguments: ProjectVideoScreen(city: city),
            ),
          ),

        /// project
        if (enabledPagesDto.activities && enabledPagesDto.project)
          ScaffoldRouteBuilder(
            route: CityProjectScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              CityProjectScreen.route,
              arguments: CityProjectScreen(city: city),
            ),
          ),

        ///medals Hackaton
        if (enabledPagesDto.activities && enabledPagesDto.hackatonMedals)
          ScaffoldRouteBuilder(
            route: MedalsMaratonScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              MedalsMaratonScreen.route,
              arguments: MedalsMaratonScreen(city: city),
            ),
          ),
      ];

  static List<ScaffoldRouteBuilder> _routes(
    /// enabled pages configuration
    CityEnabledPagesDto enabledPagesDto,

    /// required city argument to load data
    CityDto city,
  ) =>
      [
        /// introduction screen
        ScaffoldRouteBuilder(
          route: CityIntroductionScreen.route,
          builder: (context) => Navigator.pushNamed(
            context,
            CityIntroductionScreen.route,
            arguments: CityIntroductionScreen(city: city),
          ),
        ),

        /// history screen
        ScaffoldRouteBuilder(
          route: StageHistoryScreen.route,
          builder: (context) => Navigator.pushNamed(
            context,
            StageHistoryScreen.route,
            arguments: StageHistoryScreen(city: city),
          ),
        ),

        /// video introduction screen
        if (enabledPagesDto.introductoryVideo)
          ScaffoldRouteBuilder(
            route: IntroductoryVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              IntroductoryVideoScreen.route,
              arguments: IntroductoryVideoScreen(city: city),
            ),
          ),

        /// Monster screen
        ScaffoldRouteBuilder(
          route: StageMonsterScreen.route,
          builder: (context) => Navigator.pushNamed(
            context,
            StageMonsterScreen.route,
            arguments: StageMonsterScreen(city: city),
          ),
        ),

        /// ideas
        if (enabledPagesDto.argumentation)
          ScaffoldRouteBuilder(
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
        ScaffoldRouteBuilder(
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
          ScaffoldRouteBuilder(
            route: ContentScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ContentScreen.route,
              arguments: ContentScreen(city: city),
            ),
          ),

        /// resources
        if (enabledPagesDto.resources)
          ScaffoldRouteBuilder(
            route: ResourcesScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ResourcesScreen.route,
              arguments: ResourcesScreen(city: city),
            ),
          ),

        /// activities
        if (enabledPagesDto.activities)
          ScaffoldRouteBuilder(
            route: ActivitiesScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ActivitiesScreen.route,
              arguments: ActivitiesScreen(city: city),
            ),
          ),

        /// clubhouse pages
        ...CityNavigator._contributionActivities(enabledPagesDto, city),

        /// clubhouse pages
        ...CityNavigator._clubhouseActivities(enabledPagesDto, city),

        /// clubhouse pages
        ...CityNavigator._projectActivities(enabledPagesDto, city),

        /// manual video
        if (enabledPagesDto.manualVideo)
          ScaffoldRouteBuilder(
            route: ManualVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ManualVideoScreen.route,
              arguments: ManualVideoScreen(city: city),
            ),
          ),

        /// micro-meso-macro
        if (enabledPagesDto.microMesoMacro)
          ScaffoldRouteBuilder(
            route: MicroMesoMacroScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              MicroMesoMacroScreen.route,
              arguments: MicroMesoMacroScreen(city: city),
            ),
          ),

        /// final video screen
        if (enabledPagesDto.finalVideo)
          ScaffoldRouteBuilder(
            route: FinalVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              FinalVideoScreen.route,
              arguments: FinalVideoScreen(city: city),
            ),
          ),
      ];

  /// get next page to navigate to
  static ScaffoldRouteBuilder? getNextPage(
      String currentRoute, CityDto cityDto) {
    final List<ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._routes(cityDto.enabledPages, cityDto);

    final int currentIndex =
        availableRoutes.indexWhere((element) => element.route == currentRoute);
    final int nextIndex = currentIndex + 1;

    /// if next index still inside array length then retrieve next page value
    /// otherwise send first item index with next city data
    if (nextIndex < availableRoutes.length) return availableRoutes[nextIndex];

    /// otherwise send to start of next city, if a next city exists
    if (cityDto.nextCity != null && nextIndex == availableRoutes.length) {
      final List<ScaffoldRouteBuilder> nextCityRoutes =
          CityNavigator._routes(cityDto.enabledPages, cityDto.nextCity!);
      return nextCityRoutes.first;
    }

    return null;
  }

  /// get first route of a city
  static ScaffoldRouteBuilder getFirsScreen(CityDto cityDto) {
    final List<ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._routes(cityDto.enabledPages, cityDto);

    return availableRoutes.first;
  }

  /// get first route of clubhouse
  static ScaffoldRouteBuilder getCLubhouseNextScreen(CityDto cityDto) {
    final List<ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._clubhouseActivities(cityDto.enabledPages, cityDto);

    return availableRoutes.first;
  }

  /// get first route contribution
  static ScaffoldRouteBuilder getContributionNextScreen(CityDto cityDto) {
    final List<ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._contributionActivities(cityDto.enabledPages, cityDto);

    return availableRoutes.first;
  }

  /// get first route of a project
  static ScaffoldRouteBuilder getProjectNextScreen(CityDto cityDto) {
    final List<ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._projectActivities(cityDto.enabledPages, cityDto);

    return availableRoutes.first;
  }
}

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/cities/activity/widgets/activities.screen.dart';
import 'package:lab_movil_2222/cities/argument-ideas/ui/screens/argument-ideas.screen.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/clubhouse-explanation.screen.dart';
import 'package:lab_movil_2222/cities/clubhouse/ui/screens/clubhouse.screen.dart';
import 'package:lab_movil_2222/cities/contribution/ui/screens/city-contribution.screen.dart';
import 'package:lab_movil_2222/cities/contribution/ui/screens/contribution-explanation.screen.dart';
import 'package:lab_movil_2222/cities/final-video/widgets/final-video.screen.dart';
import 'package:lab_movil_2222/cities/manual-video/widgets/manual-video.screen.dart';
import 'package:lab_movil_2222/cities/micro-meso-macro/ui/screens/micro-meso-macro.screen.dart';
import 'package:lab_movil_2222/cities/monster/ui/screens/stageMonster.screen.dart';
import 'package:lab_movil_2222/cities/project-awards/ui/screens/project-awards.screen.dart';
import 'package:lab_movil_2222/cities/project-video/widgets/project-video.screen.dart';
import 'package:lab_movil_2222/cities/project/ui/screens/project.screen.dart';
import 'package:lab_movil_2222/home-map/models/city-enabled-pages.model.dart';
import 'package:lab_movil_2222/home-map/models/city.dto.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-introduction.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/content.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/introductory-video.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/thanks-videos/widgets/next-phase-video.screen.dart';

class ScaffoldRouteBuilder {
  ScaffoldRouteBuilder({
    required this.route,
    required this.builder,
  });
  final String route;
  final Future<void> Function(BuildContext) builder;
}

mixin CityNavigator {
  /// get pages for the clubhouse
  static List<ScaffoldRouteBuilder> _clubhouseActivities(
    /// enabled pages configuration
    CityEnabledPagesModel enabledPagesDto,

    /// required city argument to load data
    CityModel city,
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
    CityEnabledPagesModel enabledPagesDto,

    /// required city argument to load data
    CityModel city,
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
            route: ContributionScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ContributionScreen.route,
              arguments: ContributionScreen(city: city),
            ),
          ),
      ];

  /// get pages for the clubhouse
  static List<ScaffoldRouteBuilder> _projectActivities(
    /// enabled pages configuration
    CityEnabledPagesModel enabledPagesDto,

    /// required city argument to load data
    CityModel city,
  ) =>
      [
        /// project video
        if (enabledPagesDto.projectVideo)
          ScaffoldRouteBuilder(
            route: ProjectVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ProjectVideoScreen.route,
              arguments: ProjectVideoScreen(cityModel: city),
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
            route: ProjectAwardsProject.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ProjectAwardsProject.route,
              arguments: ProjectAwardsProject(city: city),
            ),
          ),
      ];

  static List<ScaffoldRouteBuilder> _routes(
    /// enabled pages configuration
    CityEnabledPagesModel enabledPagesDto,

    /// required city argument to load data
    CityModel city,
  ) =>
      [
        /// introduction screen
        ScaffoldRouteBuilder(
          route: CityIntroductionScreen.route,
          builder: (context) => Navigator.pushNamed(
            context,
            CityIntroductionScreen.route,
            arguments: CityIntroductionScreen(cityModel: city),
          ),
        ),

        /// history screen
        ScaffoldRouteBuilder(
          route: StageHistoryScreen.route,
          builder: (context) => Navigator.pushNamed(
            context,
            StageHistoryScreen.route,
            arguments: StageHistoryScreen(cityModel: city),
          ),
        ),

        /// video introduction screen
        if (enabledPagesDto.introductoryVideo)
          ScaffoldRouteBuilder(
            route: IntroductoryVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              IntroductoryVideoScreen.route,
              arguments: IntroductoryVideoScreen(cityModel: city),
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
            route: ArgumentIdeasScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              ArgumentIdeasScreen.route,
              arguments: ArgumentIdeasScreen(
                city: city,
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
              city: city,
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
              arguments: ContentScreen(cityModel: city),
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
              arguments: ManualVideoScreen(cityModel: city),
            ),
          ),

        /// micro-meso-macro
        if (enabledPagesDto.microMesoMacro)
          ScaffoldRouteBuilder(
            route: MicroMesoMacroScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              MicroMesoMacroScreen.route,
              arguments: MicroMesoMacroScreen(cityModel: city),
            ),
          ),

        /// next Phase screen
        if (enabledPagesDto.nextPhaseVideo)
          ScaffoldRouteBuilder(
            route: NextPhaseVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              NextPhaseVideoScreen.route,
              arguments: NextPhaseVideoScreen(cityModel: city),
            ),
          ),

        /// final video screen
        if (enabledPagesDto.finalVideo)
          ScaffoldRouteBuilder(
            route: FinalVideoScreen.route,
            builder: (context) => Navigator.pushNamed(
              context,
              FinalVideoScreen.route,
              arguments: FinalVideoScreen(cityModel: city),
            ),
          ),
      ];

  /// get next page to navigate to
  static ScaffoldRouteBuilder? getNextPage(
      String currentRoute, CityModel cityDto) {
    final List<ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._routes(cityDto.enabledPages, cityDto);

    final int currentIndex =
        availableRoutes.indexWhere((element) => element.route == currentRoute);
    final int nextIndex = currentIndex + 1;

    /// if next index still inside array length then retrieve next page value
    /// otherwise send first item index with next city data
    if (nextIndex < availableRoutes.length) {
      return availableRoutes[nextIndex];
    }

    /// otherwise send to start of next city, if a next city exists
    if (cityDto.nextCity != null && nextIndex == availableRoutes.length) {
      final List<ScaffoldRouteBuilder> nextCityRoutes =
          CityNavigator._routes(cityDto.enabledPages, cityDto.nextCity!);
      return nextCityRoutes.first;
    }

    return null;
  }

  /// get first route of a city
  static ScaffoldRouteBuilder getFirsScreenOfCity(CityModel cityDto) {
    final List<ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._routes(cityDto.enabledPages, cityDto);

    return availableRoutes.first;
  }

  /// get first route of clubhouse
  static ScaffoldRouteBuilder getCLubhouseNextScreen(CityModel cityDto) {
    final List<ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._clubhouseActivities(cityDto.enabledPages, cityDto);

    return availableRoutes.first;
  }

  /// get first route contribution
  static ScaffoldRouteBuilder getContributionNextScreen(CityModel cityDto) {
    final List<ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._contributionActivities(cityDto.enabledPages, cityDto);

    return availableRoutes.first;
  }

  /// get first route of a project
  static ScaffoldRouteBuilder getProjectNextScreen(CityModel cityDto) {
    final List<ScaffoldRouteBuilder> availableRoutes =
        CityNavigator._projectActivities(cityDto.enabledPages, cityDto);

    return availableRoutes.first;
  }
}

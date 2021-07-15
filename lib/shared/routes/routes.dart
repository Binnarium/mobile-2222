import 'package:flutter/material.dart';
import 'package:lab_movil_2222/screens/chapter_screens/activities.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/chapterClubhouse.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageArgumentation.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/content.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageMonster.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/screens/cities.screen.dart';
import 'package:lab_movil_2222/screens/club_house.screen.dart';
import 'package:lab_movil_2222/screens/goals.screen.dart';
import 'package:lab_movil_2222/screens/login.screen.dart';
import 'package:lab_movil_2222/screens/profile.screen.dart';
import 'package:lab_movil_2222/screens/splash.screen.dart';
import 'package:lab_movil_2222/screens/statistics.screen.dart';
import 'package:lab_movil_2222/screens/teamSheet.screen.dart';

MaterialPageRoute<dynamic> buildMaterialPageRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) {
      switch (settings.name) {
        case SplashScreen.route:
          return SplashScreen();

        case TeamScreen.route:
          return TeamScreen();

        case LoginScreen.route:
          return LoginScreen();

        case ClubHouseScreen.route:
          return ClubHouseScreen();

        case StatisticsScreen.route:
          return StatisticsScreen();

        case CitiesScreen.route:
          return CitiesScreen();

        case StatisticsScreen.route:
          return StatisticsScreen();

        case GoalsScreen.route:
          return GoalsScreen();

        case ProfileScreen.route:
          return ProfileScreen();

        case StageIntroductionScreen.route:
          final args = settings.arguments as StageIntroductionScreen;
          return StageIntroductionScreen(
            chapterSettings: args.chapterSettings,
          );

        case StageHistoryScreen.route:
          final args = settings.arguments as StageHistoryScreen;
          return StageHistoryScreen(
            chapterSettings: args.chapterSettings,
          );

        case StageMonsterScreen.route:
          final args = settings.arguments as StageMonsterScreen;
          return StageMonsterScreen(
            chapterSettings: args.chapterSettings,
          );
        case StageArgumentationScreen.route:
          final args = settings.arguments as StageArgumentationScreen;
          return StageArgumentationScreen(
            chapterSettings: args.chapterSettings,
          );

        case StageObjetivesScreen.route:
          final args = settings.arguments as StageObjetivesScreen;
          return StageObjetivesScreen(
            chapterSettings: args.chapterSettings,
          );

        case ContentScreen.route:
          final args = settings.arguments as ContentScreen;
          return ContentScreen(
            chapterSettings: args.chapterSettings,
          );

        case ResourcesScreen.route:
          final args = settings.arguments as ResourcesScreen;
          return ResourcesScreen(
            chapterSettings: args.chapterSettings,
          );

        case ActivitiesScreen.route:
          final args = settings.arguments as ActivitiesScreen;
          return ActivitiesScreen(
            chapterSettings: args.chapterSettings,
          );

        case ChapterClubhouseScreen.route:
          final args = settings.arguments as ChapterClubhouseScreen;
          return ChapterClubhouseScreen(
            chapterSettings: args.chapterSettings,
          );

        default:
          return CitiesScreen();
      }
    },
  );
}

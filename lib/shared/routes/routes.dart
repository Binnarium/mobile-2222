import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/chat/screens/chat.screen.dart';
import 'package:lab_movil_2222/chat/screens/list-chats.screen.dart';
import 'package:lab_movil_2222/cities/manual-video/widgets/manual-video.screen.dart';
import 'package:lab_movil_2222/cities/project-video/widgets/project-video.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/activities.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/chapterClubhouse.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-introduction.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/city-project.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/club_house.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/content.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/introductory-video.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageArgumentation.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageHistory.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageMonster.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/screens/goals.screen.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/screens/login.screen.dart';
import 'package:lab_movil_2222/screens/profile.screen.dart';
import 'package:lab_movil_2222/screens/splash.screen.dart';
import 'package:lab_movil_2222/screens/statistics.screen.dart';
import 'package:lab_movil_2222/screens/team.screen.dart';
import 'package:lab_movil_2222/screens/welcome.screen.dart';

MaterialPageRoute<dynamic> buildMaterialPageRoute(RouteSettings settings) {
  return MaterialPageRoute(
    builder: (context) {
      switch (settings.name) {
        case SplashScreen.route:
          return SplashScreen();

        case WelcomeScreen.route:
          return WelcomeScreen();

        case TeamScreen.route:
          return TeamScreen();

        case LoginScreen.route:
          return LoginScreen();

        case ClubHouseScreen.route:
          return ClubHouseScreen();

        case StatisticsScreen.route:
          return StatisticsScreen();

        case HomeScreen.route:
          return HomeScreen();

        case StatisticsScreen.route:
          return StatisticsScreen();

        case GoalsScreen.route:
          return GoalsScreen();

        case ProfileScreen.route:
          return ProfileScreen();

        case CityIntroductionScreen.route:
          final args = settings.arguments as CityIntroductionScreen;
          return CityIntroductionScreen(
            city: args.city,
          );

        /// all chats screens
        case ListChatsScreen.route:
          return ListChatsScreen();

        case ChatScreen.route:
          final args = settings.arguments as ChatScreen;
          return ChatScreen(
            chat: args.chat,
          );
        case IntroductoryVideoScreen.route:
          final args = settings.arguments as IntroductoryVideoScreen;
          return IntroductoryVideoScreen(
            city: args.city,
          );

        case StageHistoryScreen.route:
          final args = settings.arguments as StageHistoryScreen;
          return StageHistoryScreen(
            city: args.city,
          );

        case StageMonsterScreen.route:
          final args = settings.arguments as StageMonsterScreen;
          return StageMonsterScreen(
            city: args.city,
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
            city: args.city,
          );

        case ResourcesScreen.route:
          final args = settings.arguments as ResourcesScreen;
          return ResourcesScreen(
            city: args.city,
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

        case ProjectVideoScreen.route:
          final args = settings.arguments as ProjectVideoScreen;
          return ProjectVideoScreen(
            city: args.city,
          );

        case CityProjectScreen.route:
          final args = settings.arguments as CityProjectScreen;
          return CityProjectScreen(
            city: args.city,
          );

        case ManualVideoScreen.route:
          final args = settings.arguments as ManualVideoScreen;
          return ManualVideoScreen(
            city: args.city,
          );

        default:
          print('-----------------');
          print('ROUTE NOT DEFINED');
          print('-----------------');

          ///TODO: Fix this bad gateway
          /// to exit the application (in theory)
          throw SystemChannels.platform.invokeMethod('SystemNavigator.pop');
      }
    },
  );
}

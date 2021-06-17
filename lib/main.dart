import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/providers/ui_bottomBar_provider.dart';
import 'package:lab_movil_2222/screens/chapter_screens/activities.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/chapterClubhouse.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageArgumentation.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageIntroduction.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageTitle.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageVideo.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/stageobjectives.screen.dart';
import 'package:lab_movil_2222/screens/club_house.screen.dart';
import 'package:lab_movil_2222/screens/goals.screen.dart';
import 'package:lab_movil_2222/screens/login.screen.dart';
import 'package:lab_movil_2222/screens/profile.screen.dart';
import 'package:lab_movil_2222/screens/route.screen.dart';
import 'package:lab_movil_2222/screens/splash.screen.dart';
import 'package:lab_movil_2222/screens/statistics.screen.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /// Para ocultar barra de estado
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new UIBottomBarProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,

        /// material app theme
        theme: ThemeData(
          fontFamily: 'Korolev',
          textTheme: korolevFont,
          platform: TargetPlatform.android,
        ),

        initialRoute: SplashScreen.route,

        /// aquí van las páginas existentes, son las rutas a las páginas (pantallas)
        onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
          switch (settings.name) {
            case SplashScreen.route:
              return SplashScreen();

            case LoginScreen.route:
              return LoginScreen();

            case ClubHouseScreen.route:
              return ClubHouseScreen();

            case StatisticsScreen.route:
              return StatisticsScreen();

            case RouteScreen.route:
              return RouteScreen();

            case StatisticsScreen.route:
              return StatisticsScreen();

            case GoalsScreen.route:
              return GoalsScreen();

            case ProfileScreen.route:
              return ProfileScreen();

            case StageTitleScreen.route:
              final args = settings.arguments as StageTitleScreen;
              return StageTitleScreen(
                chapterSettings: args.chapterSettings,
              );

            case StageIntroductionScreen.route:
              final args = settings.arguments as StageIntroductionScreen;
              return StageIntroductionScreen(
                chapterSettings: args.chapterSettings,
              );

            case StageObjetivesScreen.route:
              final args = settings.arguments as StageObjetivesScreen;
              return StageObjetivesScreen(
                chapterSettings: args.chapterSettings,
              );

            case StageArgumentationScreen.route:
              final args = settings.arguments as StageArgumentationScreen;
              return StageArgumentationScreen(
                chapterSettings: args.chapterSettings,
              );

            case StageVideoScreen.route:
              final args = settings.arguments as StageVideoScreen;
              return StageVideoScreen(
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
              return SplashScreen();
          }
        }),
      ),
    );
  }
}

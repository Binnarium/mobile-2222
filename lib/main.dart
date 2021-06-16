import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/providers/ui_bottomBar_provider.dart';
import 'package:lab_movil_2222/screens/chapter_screens/activities.screen.dart';
import 'package:lab_movil_2222/screens/chapter_screens/resources.screen.dart';
import 'package:lab_movil_2222/screens/splash.screen.dart';
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

        initialRoute: ResourcesScreen.route,

        /// aquí van las páginas existentes, son las rutas a las páginas (pantallas)
        onGenerateRoute: (settings) => MaterialPageRoute(builder: (context) {
          if (settings.name == SplashScreen.route) return SplashScreen();
          if (settings.name == ResourcesScreen.route) return ResourcesScreen();

          final args = settings.arguments as ActivitiesScreen;

          if (settings.name == ActivitiesScreen.route)
            return ActivitiesScreen(
              primaryColor: args.primaryColor,
            );

          return SplashScreen();
          // SplashScreen.route:  SplashScreen(),
          // AccountScreen.route: (BuildContext context) => AccountScreen(),
          // LoginScreen.route: (BuildContext context) => LoginScreen(),
          // RouteScreen.route: (BuildContext context) => RouteScreen(),
          // GoalsScreen.route: (BuildContext context) => GoalsScreen(),
          // ClubHouseScreen.route: (BuildContext context) => ClubHouseScreen(),
          // StatisticsScreen.route: (BuildContext context) => StatisticsScreen(),
        }),
      ),
    );
  }
}

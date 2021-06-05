import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/providers/ui_bottomBar_provider.dart';
import 'package:lab_movil_2222/screens/account.screen.dart';
import 'package:lab_movil_2222/screens/club_house.screen.dart';
import 'package:lab_movil_2222/screens/goals.screen.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/screens/login.screen.dart';
import 'package:lab_movil_2222/screens/route.screen.dart';
import 'package:lab_movil_2222/screens/splash.screen.dart';
import 'package:lab_movil_2222/screens/statistics.screen.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Para ocultar barra de estado
    SystemChrome.setEnabledSystemUIOverlays([]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => new UIBottomBarProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Korolev', textTheme: korolevFont),
        initialRoute: SplashScreen.route,
        //aquí van las páginas existentes, son las rutas a las páginas (pantallas)
        routes: {
          HomeScreen.route: (BuildContext context) => HomeScreen(),
          SplashScreen.route: (BuildContext context) => SplashScreen(),
          AccountScreen.route: (BuildContext context) => AccountScreen(),
          LoginScreen.route: (BuildContext context) => LoginScreen(),
          RouteScreen.route: (BuildContext context) => RouteScreen(),
          GoalsScreen.route: (BuildContext context) => GoalsScreen(),
          ClubHouseScreen.route: (BuildContext context) => ClubHouseScreen(),
          StatisticsScreen.route: (BuildContext context) => StatisticsScreen(),
        },
      ),
    );
  }
}

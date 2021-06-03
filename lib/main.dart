import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/src/pages/account_page.dart';
import 'package:lab_movil_2222/src/pages/club_house_page.dart';
import 'package:lab_movil_2222/src/pages/goals_page.dart';
import 'package:lab_movil_2222/src/pages/home_page.dart';
import 'package:lab_movil_2222/src/pages/initial_page.dart';
import 'package:lab_movil_2222/src/pages/route_page.dart';
import 'package:lab_movil_2222/src/pages/statistics_page.dart';
import 'package:lab_movil_2222/src/providers/ui_bottomBar_provider.dart';
import 'package:lab_movil_2222/src/themes/theme.dart';
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
        initialRoute: 'homePage',
        //aquí van las páginas existentes, son las rutas a las páginas (pantallas)
        routes: {
          'initialPage': (BuildContext context) => InitialPage(),
          'homePage': (BuildContext context) => HomePage(),
          'routePage': (BuildContext context) => RoutePage(),
          'goalsPage': (BuildContext context) => GoalsPage(),
          'accountPage': (BuildContext context) => AccountPage(),
          'clubHousePage': (BuildContext context) => ClubHousePage(),
          'statsPage': (BuildContext context) => StatisticsPage(),
        },
      ),
    );
  }
}

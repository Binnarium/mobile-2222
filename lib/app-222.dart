import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/providers/ui_bottomBar_provider.dart';
import 'package:lab_movil_2222/screens/cities-map.screen.dart';
import 'package:lab_movil_2222/screens/splash.screen.dart';
import 'package:lab_movil_2222/shared/routes/routes.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:provider/provider.dart';

class App2222 extends StatelessWidget {
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
        title: 'Lab Móvil 2222',

        /// TODO: show banner only on development
        debugShowCheckedModeBanner: false,

        /// material app theme
        theme: ThemeData(
          fontFamily: 'Korolev',
          textTheme: korolevFont.apply(bodyColor: Colors.black),
          accentColor: ColorsApp.backgroundBottomBar,
          splashColor: ColorsApp.backgroundBottomBar,
        ),

        initialRoute: CitiesMapScreen.route,

        /// aquí van las páginas existentes, son las rutas a las páginas (pantallas)
        onGenerateRoute: (settings) => buildMaterialPageRoute(settings),
      ),
    );
  }
}

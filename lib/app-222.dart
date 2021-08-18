import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/providers/audioPlayer_provider.dart';
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
          create: (_) => AudioPlayerProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Lab Móvil 2222',

        /// TODO: show banner only on development
        debugShowCheckedModeBanner: false,

        /// material app theme
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: KorolevFont.fontFamily,
          textTheme: KorolevFont(),
          primaryTextTheme: KorolevFont(textColor: Colors2222.black),
          colorScheme: ColorScheme.dark(
            primary: Colors2222.white,
            onPrimary: Colors2222.black,
            background: Colors2222.red,
          ),
        ),

        initialRoute: SplashScreen.route,

        /// aquí van las páginas existentes, son las rutas a las páginas (pantallas)
        onGenerateRoute: (settings) => buildMaterialPageRoute(settings),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/assets/image/services/upload-image.service.dart';
import 'package:lab_movil_2222/providers/audioPlayer_provider.dart';
import 'package:lab_movil_2222/providers/videoPlayer_provider.dart';
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
        ),
        ChangeNotifierProvider(
          create: (_) => VideoPlayerProvider(),
        ),
        Provider(create: (context) => UploadImageService())
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
        ),

        initialRoute: SplashScreen.route,

        /// aquí van las páginas existentes, son las rutas a las páginas (pantallas)
        onGenerateRoute: (settings) => buildMaterialPageRoute(settings),
      ),
    );
  }
}

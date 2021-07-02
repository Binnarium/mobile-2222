import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/providers/ui_bottomBar_provider.dart';
import 'package:lab_movil_2222/screens/splash.screen.dart';
import 'package:lab_movil_2222/shared/routes/routes.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

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
        onGenerateRoute: (settings) => buildMaterialPageRoute(settings),
      ),
    );
  }
}

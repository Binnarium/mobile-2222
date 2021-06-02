import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/src/pages/initial_page.dart';
import 'package:lab_movil_2222/src/providers/ui_bottomBar_provider.dart';
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
        theme: ThemeData(fontFamily: 'Korolev'),
        initialRoute: 'initialPage',
        //aquí van las páginas existentes, son las rutas a las páginas (pantallas)
        routes: {
          'initialPage': (BuildContext context) => InitialPage(),
        },
      ),
    );
  }
}

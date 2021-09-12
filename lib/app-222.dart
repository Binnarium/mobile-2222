import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab_movil_2222/app-routes.dart';
import 'package:lab_movil_2222/assets/audio/services/current-audio.provider.dart';
import 'package:lab_movil_2222/assets/image/services/upload-image.service.dart';
import 'package:lab_movil_2222/assets/video/services/current-video.provider.dart';
import 'package:lab_movil_2222/chat/services/create-personal-chats.service.dart';
import 'package:lab_movil_2222/chat/services/get-chat.service.dart';
import 'package:lab_movil_2222/cities/activity/services/load-activity.service.dart';
import 'package:lab_movil_2222/cities/clubhouse/services/get-clubhouse-explanation.service.dart';
import 'package:lab_movil_2222/cities/contribution/services/get-clubhouse-explanation.service.dart';
import 'package:lab_movil_2222/cities/monster/services/load-monster.service.dart';
import 'package:lab_movil_2222/cities/project/services/upload-file.service.dart';
import 'package:lab_movil_2222/player/services/search-players.service.dart';
import 'package:lab_movil_2222/screens/splash.screen.dart';
import 'package:lab_movil_2222/services/load-player-information.service.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/themes/textTheme.dart';
import 'package:provider/provider.dart';

import 'assets/video/services/upload-video.service.dart';
import 'cities/project/services/load-project-files.service.dart';

class App2222 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => CurrentAudioProvider()),
        Provider(create: (_) => CurrentVideoProvider()),
        Provider(create: (_) => UploadImageService()),
        Provider(create: (_) => UploadVideoService()),
        Provider(create: (_) => GetContributionExplanationService()),
        Provider(create: (_) => GetClubhouseExplanationService()),
        Provider(create: (_) => LoadMonsterService()),
        Provider(create: (_) => LoadProjectFiles()),
        Provider(create: (_) => UploadFileService()),
        Provider(create: (_) => GetChatService()),
        Provider(create: (_) => CreatePersonalChatService()),
        Provider(create: (_) => SearchPlayersService()),
        Provider(create: (_) => LoadPlayerService()),

        ///cities loaders
        Provider(create: (_) => LoadCityActivitiesService()),
      ],
      child: MaterialApp(
        title: 'Lab Móvil 2222',

        /// material app theme
        theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: KorolevFont.fontFamily,
          textTheme: KorolevFont(),
          primaryTextTheme: KorolevFont(textColor: Colors2222.black),
        ),

        initialRoute: SplashScreen.route,

        /// aquí van las páginas existentes, son las rutas a las páginas (pantallas)
        onGenerateRoute: (settings) => Lab2222Routes(settings),
      ),
    );
  }
}

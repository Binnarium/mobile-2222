import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/shared/widgets/content-title.widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/team/ui/widgets/goto-team-button.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/widgets/widgets/listSocialNetworks.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown-card.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/bottom-navigation-bar-widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class WelcomeScreen extends StatefulWidget {
  static const String route = '/welcome';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  WelcomeDto? loginPayload;

  StreamSubscription? _loadLoginPayload;

  WelcomeService get loadLoginInfoService =>
      Provider.of<WelcomeService>(context, listen: false);

  @override
  void initState() {
    super.initState();

    _loadLoginPayload = loadLoginInfoService.load$.listen(
      (welcomeDto) {
        if (mounted) {
          setState(() {
            loginPayload = welcomeDto;
          });
        }
      },
    );
  }

  @override
  void dispose() {
    _loadLoginPayload?.cancel();
    super.dispose();
  }

  ///página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    ///safeArea para dispositivos con pantalla notch
    return SafeArea(
      child: Scaffold2222.navigation(
        activePage: Lab2222NavigationBarPages.information,

        ///Stack para apilar el background y luego el cuerpo de la pantalla
        body: Stack(
          children: [
            ///Container del color rojo
            ///Deprecated ignore cause Scaffold2222 needs city
            // ignore: deprecated_member_use_from_same_package
            const CustomBackground(
              backgroundColor: Colors2222.red,
            ),

            ///contiene todo el cuerpo de la pantalla, se envía el size y el context
            ///para poder controlar varios tamaños de dispositivos y controlar
            ///la fuente
            _loginBody(size, context),
          ],
        ),
      ),
    );
  }

  ///Cuerpo de la pantalla
  ListView _loginBody(Size size, BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final horizontalPadding = size.width * 0.08;
    return ListView(
      padding: const EdgeInsets.symmetric(vertical: 64),
      children: [
        /// app logo
        Padding(
          padding: EdgeInsets.only(
              left: horizontalPadding, right: horizontalPadding, bottom: 40),
          child: Center(
            child: AppLogo(
              kind: AppImage.defaultAppLogo,
              width: min(350, size.width * 0.6),
            ),
          ),
        ),

        /// App Title
        Padding(
          padding: EdgeInsets.only(
              left: horizontalPadding, right: horizontalPadding, bottom: 32),
          child: Text(
            'Lab Móvil 2222'.toUpperCase(),
            style: textTheme.headline6!.apply(fontSizeFactor: 1.3),
            textAlign: TextAlign.center,
          ),
        ),

        /// loading animation
        if (loginPayload == null)
          const Center(
            child: AppLoading(),
          )

        /// data is available
        /// logo de 2222
        else ...[
          /// principal text
          Padding(
            padding: EdgeInsets.only(
                left: horizontalPadding, right: horizontalPadding, bottom: 20),
            child: Text(
              loginPayload!.pageTitle,
              style: textTheme.subtitle2?.apply(fontSizeFactor: 1.2),
              textAlign: TextAlign.center,
            ),
          ),

          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: ContentTitleWidget(
                author: 'Santiago Acosta Aide',
                title: 'Bienvenida del Rector UTPL',
                kind: ' - vídeo'),
          ),

          /// video container
          Padding(
              padding: EdgeInsets.only(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: 20),
              child: VideoPlayer(
                video: loginPayload!.welcomeVideo,
              )),

          /// profundity text
          Padding(
            padding: EdgeInsets.only(
                left: horizontalPadding, right: horizontalPadding, bottom: 28),
            child: Markdown2222(
              data: loginPayload!.profundityText,
            ),
          ),

          /// team button
          Padding(
            padding: EdgeInsets.only(
                left: horizontalPadding, right: horizontalPadding, bottom: 24),
            child: const GotoTeamButton(),
          ),

          /// white container text
          Padding(
            padding: EdgeInsets.only(
                left: horizontalPadding, right: horizontalPadding, bottom: 16),
            child: MarkdownCard(
              content: loginPayload!.workloadText,
            ),
          ),
          ///Social Networks
          Padding(
            padding: const EdgeInsets.only(bottom: 26, top: 26),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                // ignore: prefer_const_constructors
                ListSocialNetwork(iconURL: 'facebook'),
                // ignore: prefer_const_constructors
                ListSocialNetwork(iconURL: 'instagram'),
                // ignore: prefer_const_constructors
                ListSocialNetwork(iconURL: 'twitter'),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

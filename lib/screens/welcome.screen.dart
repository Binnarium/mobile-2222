import 'dart:math';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';
import 'package:lab_movil_2222/screens/team.screen.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/shared/widgets/custom-background.dart';
import 'package:lab_movil_2222/shared/widgets/markdown.widget.dart';
import 'package:lab_movil_2222/shared/widgets/videoPlayer_widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';

class WelcomeScreen extends StatefulWidget {
  static const String route = '/welcome';

  final ILoadInformationService<WelcomeDto> loader =
      LoadLoginInformationService();

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  WelcomeDto? loginPayload;

  @override
  void initState() {
    super.initState();

    this
        .widget
        .loader
        .load()
        .then((value) => this.setState(() => this.loginPayload = value));
  }

  ///página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    ///safeArea para dispositivos con pantalla notch
    return SafeArea(
      child: Scaffold(
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 1.0,
          backgroundColor: Colors2222.red,
        ),

        ///Stack para apilar el background y luego el cuerpo de la pantalla
        body: Stack(
          children: [
            ///Container del color rojo
            ///Deprecated ignore cause Scaffold2222 needs city
            // ignore: deprecated_member_use_from_same_package
            CustomBackground(
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
  _loginBody(Size size, BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.08, vertical: 64),
      children: [
        /// app logo
        Padding(
          padding: const EdgeInsets.only(bottom: 40),
          child: Center(
            child: AppLogo(
              kind: AppImage.defaultAppLogo,
              width: min(350, size.width * 0.6),
            ),
          ),
        ),

        /// App Title
        Padding(
          padding: const EdgeInsets.only(bottom: 32),
          child: Text(
            'Lab Móvil 2222'.toUpperCase(),
            style: textTheme.headline6!.apply(fontSizeFactor: 1.3),
            textAlign: TextAlign.center,
          ),
        ),

        /// loading animation
        if (this.loginPayload == null)
          Center(
            child: AppLoading(),
          )

        /// data is available
        /// logo de 2222
        else ...[
          /// principal text
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              this.loginPayload!.pageTitle,
              style: textTheme.subtitle2?.apply(fontSizeFactor: 1.2),
              textAlign: TextAlign.center,
            ),
          ),

          /// video container
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: (!kIsWeb)
                ? VideoPlayer(
                    video: this.loginPayload!.welcomeVideo,
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image(
                        image:
                            this.loginPayload!.welcomeVideo.placeholderImage),
                  ),
          ),

          /// profundity text
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Markdown2222(
              data: this.loginPayload!.profundityText,
            ),
          ),

          /// team button
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, TeamScreen.route),
                child: Text(
                  'Equipo 2222',
                  style: textTheme.headline5?.apply(
                      decoration: TextDecoration.underline,
                      fontSizeFactor: 0.7),
                ),
              ),
            ),
          ),

          /// white container text
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: WorkloadMarkdown(
              workload: this.loginPayload!.workloadText,
            ),
          ),
        ],
      ],
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/authentication/login/login.screen.dart';
import 'package:lab_movil_2222/authentication/register/register.screen.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';
import 'package:lab_movil_2222/screens/welcome.screen.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/shared/widgets/content-title.widget.dart';
import 'package:lab_movil_2222/team/ui/widgets/goto-team-button.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown-card.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';
import 'package:provider/provider.dart';

class AuthenticationHomeScreen extends StatefulWidget {
  const AuthenticationHomeScreen({Key? key}) : super(key: key);

  static const String route = '/authentication-home';

  @override
  State<AuthenticationHomeScreen> createState() =>
      _AuthenticationHomeScreenState();
}

class _AuthenticationHomeScreenState extends State<AuthenticationHomeScreen> {
  WelcomeDto? loginPayload;
  StreamSubscription? _loadLoginPayload;
  WelcomeService get loadLoginInfoService =>
      Provider.of<WelcomeService>(context, listen: false);
  @override
  void initState() {
    super.initState();

    _loadLoginPayload = loadLoginInfoService.load$.listen((welcomeDto) {
      if (mounted)
        setState(() {
          loginPayload = welcomeDto;
        });
    });
  }

  @override
  void dispose() {
    _loadLoginPayload?.cancel();
    super.dispose();
  }

  ///página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final horizontalPadding = size.width * 0.08;

    ///safeArea para dispositivos con pantalla notch
    return Scaffold2222.empty(
      backgroundColor: Colors2222.red,
      body: BackgroundDecoration(
        backgroundDecorationsStyles: const [
          BackgroundDecorationStyle.bottomRight
        ],
        child: ListView(
          padding: const EdgeInsets.only(top: 84, bottom: 44),
          children: [
            /// app logo
            Center(
              child: Hero(
                tag: 'app-logo',
                child: AppLogo(
                  kind: AppImage.defaultAppLogo,
                  width: min(350, size.width * 0.6),
                ),
              ),
            ),

            /// spacing
            const SizedBox(height: 40),

            /// App Title
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: Text(
                'Lab Móvil 2222'.toUpperCase(),
                style: textTheme.headline6!.apply(fontSizeFactor: 1.3),
                textAlign: TextAlign.center,
              ),
            ),

            /// spacing
            const SizedBox(height: 32),

            /// loading animation
            if (loginPayload == null)
              const Center(
                child: AppLoading(),
              )

            /// screen content
            else ...[
              /// principal text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text(
                  loginPayload!.pageTitle,
                  style: textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),

              /// spacing
              const SizedBox(height: 32),

              /// video container
              const ContentTitleWidget(
                author: 'Santiago Acosta Aide',
                title: 'Bienvenida del Rector UTPL',
                kind: ' - vídeo',
              ),

              /// spacing
              const SizedBox(height: 32),

              /// welcome video
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: VideoPlayer(
                  video: loginPayload!.welcomeVideo,
                ),
              ),

              /// spacing
              const SizedBox(height: 32),

              /// profundity text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Markdown2222(
                  data: loginPayload!.profundityText,
                ),
              ),

              /// spacing
              const SizedBox(height: 32),

              /// team button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const GotoTeamButton(),
              ),

              /// spacing
              const SizedBox(height: 32),

              /// profundity text
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: MarkdownCard(content: loginPayload!.workloadText),
              ),

              /// spacing
              const SizedBox(height: 24),

              ///Social Networks
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: const SocialNetworks(),
              ),

              /// spacing
              const SizedBox(height: 32),

              /// formulary to create new account
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors2222.white,
                    elevation: 5,
                  ),
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, RegisterScreen.route),
                  child: const Text(
                    'No tienes cuenta? Comienza tu aventura!',
                    style: TextStyle(color: Colors2222.black),
                  ),
                ),
              ),

              /// spacing
              const SizedBox(height: 16),

              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: horizontalPadding * 2),
                child: Divider(
                  color: Colors2222.white,
                ),
              ),

              /// spacing
              const SizedBox(height: 16),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors2222.white,
                    elevation: 5,
                  ),
                  child: const Text(
                    '¿Ya tienes una cuenta? Inicia Sesión!',
                    style: TextStyle(color: Colors2222.black),
                  ),
                  onPressed: () => Navigator.pushReplacementNamed(
                      context, LoginScreen.route),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

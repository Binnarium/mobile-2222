import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/authentication/login/login-formulary.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/scaffold-2222/widgets/scaffold-2222.widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  static const String route = '/login';

  ///página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final horizontalPadding = size.width * 0.08;

    ///safeArea para dispositivos con pantalla notch
    return Scaffold2222.empty(
      backgroundColor: Colors2222.primary,

      ///Stack para apilar el background y luego el cuerpo de la pantalla
      body: BackgroundDecoration(
        backgroundDecorationsStyles: const [BackgroundDecorationStyle.topLeft],
        child: ListView(
          padding: const EdgeInsets.only(top: 84, bottom: 32),
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

            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: const LoginFormulary(),
            ),

            /// spacing
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

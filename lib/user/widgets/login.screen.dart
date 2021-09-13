import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/assets/video/ui/widgets/video-player.widget.dart';
import 'package:lab_movil_2222/interfaces/i-load-information.service.dart';
import 'package:lab_movil_2222/models/welcome.dto.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/screens/home.screen.dart';
import 'package:lab_movil_2222/services/load-login-information.service.dart';
import 'package:lab_movil_2222/shared/widgets/app-loading.widget.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/team/ui/widgets/goto-team-button.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/models/login-form.model.dart';
import 'package:lab_movil_2222/user/services/login-user.service.dart';
import 'package:lab_movil_2222/user/widgets/register.screen.dart';
import 'package:lab_movil_2222/user/widgets/widgets/authentication-snackbar.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown-card.widget.dart';
import 'package:lab_movil_2222/widgets/markdown/markdown.widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  static const String route = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  WelcomeDto? loginPayload;

  StreamSubscription? _loadLoginPayload;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginFormModel _formValue = LoginFormModel.empty();

  final ILoginService _loginService = LoginService();

  @override
  void initState() {
    super.initState();
    LoadLoginInformationService loadLoginInfoService =
        Provider.of<LoadLoginInformationService>(this.context, listen: false);

    this._loadLoginPayload = loadLoginInfoService.load$().listen(
      (welcomeDto) {
        if (this.mounted)
          this.setState(() {
            this.loginPayload = welcomeDto;
          });
      },
    );
  }

  @override
  void dispose() {
    this._loadLoginPayload?.cancel();
    super.dispose();
  }

  ///página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;

    ///safeArea para dispositivos con pantalla notch
    return Form(
      key: this._formKey,
      child: Scaffold(
        backgroundColor: Colors2222.primary,

        ///Stack para apilar el background y luego el cuerpo de la pantalla
        body: BackgroundDecoration(
          backgroundDecorationsStyles: [BackgroundDecorationStyle.topLeft],
          child: ListView(
            padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.08, vertical: 64),
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
                    child: VideoPlayer(
                      video: this.loginPayload!.welcomeVideo,
                    )),

                /// profundity text
                Padding(
                  padding: const EdgeInsets.only(bottom: 28),
                  child: Markdown2222(
                    data: this.loginPayload!.profundityText,
                  ),
                ),

                /// team button
                Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: GotoTeamButton(),
                ),

                /// profundity text
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: MarkdownCard(
                    content: this.loginPayload!.workloadText,
                  ),
                ),

                /// formulario (falta aplicar backend)
                Text(
                  'Comienza tu aventura',
                  style: textTheme.headline6!.apply(fontSizeFactor: 1.3),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),

                /// email input
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField222(
                    label: 'Correo Electrónico',
                    keyboardType: TextInputType.emailAddress,
                    onValueChanged: (email) => this._formValue.email = email!,
                    validator: _validateEmail,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: TextFormField222.password(
                    label: 'Contraseña',
                    onValueChanged: (password) =>
                        this._formValue.password = password!,
                    validator: _validatePassword,
                  ),
                ),

                /// sign in button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors2222.black,
                    elevation: 5,
                  ),
                  child: Text('Iniciar Sesión'),
                  onPressed: _handleLogin,
                ),

                /// register
                TextButton(
                  onPressed: () =>
                      Navigator.pushNamed(context, RegisterScreen.route),
                  style: TextButton.styleFrom(primary: Colors2222.white),
                  child: Text('¿No tienes cuenta? Regístrate aquí'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String? _validatePassword(value) {
    final int numberCaracteres = 6;
    if (value == null || value.isEmpty) {
      return 'Ingresa una contraseña valida';
    }
    if (value.length < numberCaracteres) {
      return 'La contraseña debe tener al menos $numberCaracteres caracteres';
    }
    return null;
  }

  String? _validateEmail(email) {
    bool emailValid = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email!);
    if (!emailValid) return 'Correo electrónico invalido';
    return null;
  }

  Future<void> _handleLogin() async {
    if (this._formKey.currentState!.validate()) {
      this._formKey.currentState!.save();

      try {
        final PlayerModel player =
            await this._loginService.login(this._formValue);
        ScaffoldMessenger.of(context).showSnackBar(
          AuthenticationSnackbar.welcome(
            displayName: player.displayName,
          ),
        );

        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      } on LoginException catch (e) {
        if (e.code == LoginErrorCode.invalidEmail)
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.invalidEmail(),
          );
        else if (e.code == LoginErrorCode.playerNotFound)
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.playerNotFound(),
          );
        else if (e.code == LoginErrorCode.userDisabled)
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.somethingWentWrong(),
          );
        else if (e.code == LoginErrorCode.userDisabled)
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.disabledAccount(),
          );
        else if (e.code == LoginErrorCode.userNotFound)
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.notRegistered(context: context),
          );
        else if (e.code == LoginErrorCode.wrongPassword)
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.wrongPassword(),
          );
        else
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.somethingWentWrong(),
          );
      }
    }
  }
}

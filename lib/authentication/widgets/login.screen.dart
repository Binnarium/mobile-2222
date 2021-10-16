import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/authentication/models/login-form.model.dart';
import 'package:lab_movil_2222/authentication/register/register.screen.dart';
import 'package:lab_movil_2222/authentication/services/login-user.service.dart';
import 'package:lab_movil_2222/authentication/widgets/widgets/authentication-snackbar.dart';
import 'package:lab_movil_2222/city/ui/screen/home.screen.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  static const String route = '/login';
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginFormModel _formValue = LoginFormModel.empty();

  ///página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final TextTheme textTheme = Theme.of(context).textTheme;
    final horizontalPadding = size.width * 0.08;

    ///safeArea para dispositivos con pantalla notch
    return Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: Colors2222.primary,

        ///Stack para apilar el background y luego el cuerpo de la pantalla
        body: BackgroundDecoration(
          // ignore: prefer_const_literals_to_create_immutables
          backgroundDecorationsStyles: [BackgroundDecorationStyle.topLeft],
          child: ListView(
            padding: const EdgeInsets.symmetric(vertical: 64),
            children: [
              /// app logo
              Padding(
                padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    bottom: 40),
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
                    left: horizontalPadding,
                    right: horizontalPadding,
                    bottom: 32),
                child: Text(
                  'Lab Móvil 2222'.toUpperCase(),
                  style: textTheme.headline6!.apply(fontSizeFactor: 1.3),
                  textAlign: TextAlign.center,
                ),
              ),

              /// formulario (falta aplicar backend)
              Text(
                'Comienza tu aventura',
                style: textTheme.headline6!.apply(fontSizeFactor: 1.3),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 15,
              ),

              /// email input
              Padding(
                padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    bottom: 15),
                child: TextFormField222(
                  label: 'Correo Electrónico',
                  keyboardType: TextInputType.emailAddress,
                  onValueChanged: (email) => _formValue.email = email!,
                  validator: _validateEmail,
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    bottom: 15),
                child: TextFormField222.password(
                  label: 'Contraseña',
                  onValueChanged: (password) => _formValue.password = password!,
                  validator: _validatePassword,
                ),
              ),

              /// sign in button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors2222.black,
                    elevation: 5,
                  ),
                  onPressed: () => _handleLogin(context),
                  child: const Text('Iniciar Sesión'),
                ),
              ),

              /// register
              TextButton(
                onPressed: () => Navigator.pushReplacementNamed(
                    context, RegisterScreen.route),
                style: TextButton.styleFrom(primary: Colors2222.white),
                child: const Text('¿No tienes cuenta? Registrate aquí'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validatePassword(String? value) {
    const int numberCaracteres = 6;
    if (value == null || value.isEmpty) {
      return 'Ingresa una contraseña valida';
    }
    if (value.length < numberCaracteres) {
      return 'La contraseña debe tener al menos $numberCaracteres caracteres';
    }
    return null;
  }

  String? _validateEmail(String? email) {
    final bool emailValid =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(email!);
    if (!emailValid) {
      return 'Correo electrónico invalido';
    }
    return null;
  }

  Future<void> _handleLogin(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        LoginService _loginService =
            Provider.of<LoginService>(context, listen: false);

        final PlayerModel player = await _loginService.login(_formValue);
        ScaffoldMessenger.of(context).showSnackBar(
          AuthenticationSnackbar.welcome(
            displayName: player.displayName,
          ),
        );

        Navigator.of(context).pushReplacementNamed(HomeScreen.route);
      } on LoginException catch (e) {
        if (e.code == LoginErrorCode.invalidEmail) {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.invalidEmail(),
          );
        } else if (e.code == LoginErrorCode.playerNotFound) {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.playerNotFound(),
          );
        } else if (e.code == LoginErrorCode.userDisabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.somethingWentWrong(),
          );
        } else if (e.code == LoginErrorCode.userDisabled) {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.disabledAccount(),
          );
        } else if (e.code == LoginErrorCode.userNotFound) {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.notRegistered(context: context),
          );
        } else if (e.code == LoginErrorCode.wrongPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.wrongPassword(),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.somethingWentWrong(),
          );
        }
      }
    }
  }
}

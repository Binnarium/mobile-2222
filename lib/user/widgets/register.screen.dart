import 'dart:math';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/home/ui/screen/home.screen.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/shared/widgets/app-logo.widget.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/user/models/register-form.model.dart';
import 'package:lab_movil_2222/user/services/register-user.service.dart';
import 'package:lab_movil_2222/user/widgets/widgets/authentication-snackbar.dart';
import 'package:lab_movil_2222/widgets/decorated-background/background-decoration.widget.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';

class RegisterScreen extends StatefulWidget {
  static const String route = '/register';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegisterFormModel _formValue = RegisterFormModel.empty();
  final IRegisterService registerService = RegisterService();

  ///página de login donde pide usuario y contraseña
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final TextTheme textTheme = Theme.of(context).textTheme;

    ///safeArea para dispositivos con pantalla notch
    return Form(
      key: this._formKey,
      child: Scaffold(
        backgroundColor: Colors2222.red,
        body: BackgroundDecoration(
          backgroundDecorationsStyles: [BackgroundDecorationStyle.bottomRight],
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
                  style: textTheme.headline4,
                  textAlign: TextAlign.center,
                ),
              ),

              /// subtitle
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Crea tu cuenta y comienza tu aventura',
                  style: textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
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

              /// password
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField222.password(
                  label: 'Contraseña',
                  onValueChanged: (password) =>
                      this._formValue.password = password!,
                  validator: _validatePassword,
                ),
              ),

              /// validate password
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: TextFormField222.password(
                  label: 'Validar Contraseña',
                  onValueChanged: (password) =>
                      this._formValue.validatePassword = password!,
                  validator: _validatePasswordsMatch,
                ),
              ),

              /// register button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors2222.black,
                  elevation: 5,
                ),
                child: Text('REGISTRATE AHORA'),
                onPressed: this._register,
              ),

              /// already have an account button
              ///
              /// back button to replace current screen with login screen
              TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(primary: Colors2222.white),
                child: Text('¿Ya tienes una cuenta? Inicia Sesión!'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validatePasswordsMatch(password) {
    if (this._formValue.password != password)
      return 'Las contraseñas no coinciden';
    return null;
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

  Future<void> _register() async {
    if (this._formKey.currentState!.validate()) {
      this._formKey.currentState!.save();
      try {
        final PlayerModel createdPlayer =
            await this.registerService.register(this._formValue);

        /// complete navigation and notify user
        ScaffoldMessenger.of(context).showSnackBar(
          AuthenticationSnackbar.welcome(
            displayName: createdPlayer.displayName,
          ),
        );

        /// navigate to home screen
        Navigator.pushReplacementNamed(context, HomeScreen.route);
      } on RegisterException catch (e) {
        /// email already in use
        if (e.code == RegisterErrorCode.emailAlreadyInUse) {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.alreadyRegistered(context: context),
          );
        } else if (e.code == RegisterErrorCode.notCreated) {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.accountNotRegistered(),
          );
        } else if (e.code == RegisterErrorCode.notInscribed) {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.notInscribed(),
          );
        } else if (e.code == RegisterErrorCode.weakPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.weakPassword(),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.somethingWentWrong(),
          );
        }
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/user/widgets/login.screen.dart';
import 'package:lab_movil_2222/user/widgets/register.screen.dart';

/// TODO:_add docs
class AuthenticationSnackbar extends SnackBar {
  /// TODO:_add docs
  AuthenticationSnackbar.somethingWentWrong({Key? key})
      : super(
          key: key,
          content: Text('Ocurrió un error, lo sentimos, vuelve a intentarlo'),
        );

  /// TODO:_add docs
  AuthenticationSnackbar.weakPassword({Key? key})
      : super(
          key: key,
          content:
              Text('Tu contraseña es muy devil, ingresa una nueva contraseña'),
        );

  /// TODO:_add docs
  AuthenticationSnackbar.notInscribed({Key? key})
      : super(
          key: key,
          content: Text('No estas inscrito para acceder al recorrido'),
        );

  /// TODO:_add docs
  AuthenticationSnackbar.accountNotRegistered({Key? key})
      : super(
          key: key,
          content: Text('No se pudo crear la cuenta, vuelve a intentarlo'),
        );

  /// TODO:_add docs
  AuthenticationSnackbar.alreadyRegistered({
    required BuildContext context,
    Key? key,
  }) : super(
          key: key,
          content: Text('Ya existe una cuenta usando este correo electrónico'),
          action: SnackBarAction(
            label: 'Inicia Sesión',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, LoginScreen.route),
          ),
        );

  /// TODO:_add docs
  AuthenticationSnackbar.notRegistered({
    required BuildContext context,
    Key? key,
  }) : super(
          key: key,
          content: Text('Aun no tienes una cuenta'),
          action: SnackBarAction(
            label: 'Registrate ahora',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, RegisterScreen.route),
          ),
        );

  /// TODO:_add docs
  AuthenticationSnackbar.invalidEmail({
    Key? key,
  }) : super(
          key: key,
          content: Text('Correo electrónico no valido'),
        );

  /// TODO:_add docs
  AuthenticationSnackbar.playerNotFound({
    Key? key,
  }) : super(
          key: key,
          content: Text('No se encontro información del jugador'),
        );

  /// TODO:_add docs
  AuthenticationSnackbar.disabledAccount({
    Key? key,
  }) : super(
          key: key,
          content: Text('Esta cuenta esta desactivada'),
        );

  /// TODO:_add docs
  AuthenticationSnackbar.wrongPassword({
    Key? key,
  }) : super(
          key: key,
          content: Text('Tu contraseña es incorrecta'),
        );

  /// TODO:_add docs
  AuthenticationSnackbar.welcome({
    required String displayName,
    Key? key,
  }) : super(
          key: key,
          content: Text('Bienvenido $displayName'),
        );
}

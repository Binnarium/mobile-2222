import 'package:flutter/material.dart';
import 'package:lab_movil_2222/user/widgets/login.screen.dart';
import 'package:lab_movil_2222/user/widgets/register.screen.dart';

/// Snackbar that is used to inform the user the state of the login function
class AuthenticationSnackbar extends SnackBar {
  /// This snackbar will appear if occurs an undefined error
  AuthenticationSnackbar.somethingWentWrong({Key? key})
      : super(
          key: key,
          content: Text('Ocurrió un error, lo sentimos, vuelve a intentarlo'),
        );

  /// This snackbar will appear if the password of the user is too weak
  AuthenticationSnackbar.weakPassword({Key? key})
      : super(
          key: key,
          content:
              Text('Tu contraseña es muy devil, ingresa una nueva contraseña'),
        );

  /// This snackbar will appear if the user is not registered
  AuthenticationSnackbar.notInscribed({Key? key})
      : super(
          key: key,
          content: Text('No estas inscrito para acceder al recorrido'),
        );

  /// This snackbar will appear if the account of the user is not created
  AuthenticationSnackbar.accountNotRegistered({Key? key})
      : super(
          key: key,
          content: Text('No se pudo crear la cuenta, vuelve a intentarlo'),
        );

  /// This snackbar will appear if the the user is registered
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

  /// This snackbar will appear if the user doesn't have an account
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

  /// This snackbar will appear if the user inserts a wrong email pattern
  AuthenticationSnackbar.invalidEmail({
    Key? key,
  }) : super(
          key: key,
          content: Text('Correo electrónico no valido'),
        );

  /// This snackbar will appear if the user is not in the Database
  AuthenticationSnackbar.playerNotFound({
    Key? key,
  }) : super(
          key: key,
          content: Text('No se encontro información del jugador'),
        );

  /// This snackbar will appear if the account is disposed
  AuthenticationSnackbar.disabledAccount({
    Key? key,
  }) : super(
          key: key,
          content: Text('Esta cuenta esta desactivada'),
        );

  /// This snackbar will appear if the password is wrong
  AuthenticationSnackbar.wrongPassword({
    Key? key,
  }) : super(
          key: key,
          content: Text('Tu contraseña es incorrecta'),
        );

  /// This snackbar will appear if the login is successful
  AuthenticationSnackbar.welcome({
    required String displayName,
    Key? key,
  }) : super(
          key: key,
          content: Text('Bienvenido $displayName'),
        );
}

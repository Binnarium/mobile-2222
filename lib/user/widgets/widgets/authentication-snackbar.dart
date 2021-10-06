import 'package:flutter/material.dart';
import 'package:lab_movil_2222/user/widgets/login.screen.dart';
import 'package:lab_movil_2222/user/widgets/register.screen.dart';

/// Snackbar that is used to inform the user the state of the login function
class AuthenticationSnackbar extends SnackBar {
  /// This snackbar will appear if occurs an undefined error
  const AuthenticationSnackbar.somethingWentWrong({Key? key})
      : super(
          key: key,
          content:
              const Text('Ocurrió un error, lo sentimos, vuelve a intentarlo'),
        );

  /// This snackbar will appear if the password of the user is too weak
  const AuthenticationSnackbar.weakPassword({Key? key})
      : super(
          key: key,
          content: const Text(
              'Tu contraseña es muy débil, ingresa una nueva contraseña'),
        );

  /// This snackbar will appear if the user is not registered
  const AuthenticationSnackbar.notInscribed({Key? key})
      : super(
          key: key,
          content: const Text('No estás inscrito para acceder al recorrido'),
        );

  /// This snackbar will appear if the account of the user is not created
  const AuthenticationSnackbar.accountNotRegistered({Key? key})
      : super(
          key: key,
          content:
              const Text('No se pudo crear la cuenta, vuelve a intentarlo'),
        );

  /// This snackbar will appear if the the user is registered
  AuthenticationSnackbar.alreadyRegistered({
    required BuildContext context,
    Key? key,
  }) : super(
          key: key,
          content:
              const Text('Ya existe una cuenta usando este correo electrónico'),
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
          content: const Text('Aún no tienes una cuenta'),
          action: SnackBarAction(
            label: 'Registrate ahora',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, RegisterScreen.route),
          ),
        );

  /// This snackbar will appear if the user inserts a wrong email pattern
  const AuthenticationSnackbar.invalidEmail({
    Key? key,
  }) : super(
          key: key,
          content: const Text('Correo electrónico no válido'),
        );

  /// This snackbar will appear if the user is not in the Database
  const AuthenticationSnackbar.playerNotFound({
    Key? key,
  }) : super(
          key: key,
          content: const Text('No se encontró información del jugador'),
        );

  /// This snackbar will appear if the account is deactivated
  const AuthenticationSnackbar.disabledAccount({
    Key? key,
  }) : super(
          key: key,
          content: const Text('Esta cuenta está desactivada'),
        );

  /// This snackbar will appear if the password is wrong
  const AuthenticationSnackbar.wrongPassword({
    Key? key,
  }) : super(
          key: key,
          content: const Text('Tu contraseña es incorrecta'),
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

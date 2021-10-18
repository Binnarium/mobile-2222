import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lab_movil_2222/authentication/sign-out/sign-out.service.dart';
import 'package:lab_movil_2222/authentication/splash/splash.screen.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:provider/provider.dart';

class LogOutButton extends StatefulWidget {
  const LogOutButton({Key? key}) : super(key: key);

  @override
  _LogOutButtonState createState() => _LogOutButtonState();
}

class _LogOutButtonState extends State<LogOutButton> {
  SignOutService get _signOutService => Provider.of(context, listen: false);

  StreamSubscription<void>? _sub;

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  ElevatedButton build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return ElevatedButton(
      onPressed: _signOut,
      style: ElevatedButton.styleFrom(
        primary: Colors2222.backgroundBottomBar,
        elevation: 5,
      ),
      child: Text(
        _sub == null ? 'Cerrar sesión' : 'Cerrando...',
        style: textTheme.button,
      ),
    );
  }

  void _signOut() {
    if (_sub != null) {
      return;
    }
    setState(() {
      _sub = _signOutService.signOut$().listen(
        (_) {
          /// shows snackbar
          ScaffoldMessenger.of(context).showSnackBar(_SignOutSnackBar(context));
          Navigator.of(context)
              .pushNamedAndRemoveUntil(SplashScreen.route, (route) => false);
        },
        onDone: () {
          setState(() {
            _sub?.cancel();
            _sub = null;
          });
        },
      );
    });
  }
}

class _SignOutSnackBar extends SnackBar {
  _SignOutSnackBar(
    BuildContext context,
  ) : super(
          content: Text(
            'Cierre de sesión exitoso.',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          backgroundColor: Colors2222.backgroundBottomBar,
          action: SnackBarAction(
            label: 'ENTENDIDO',
            textColor: Colors.blue.shade300,
            onPressed: ScaffoldMessenger.of(context).hideCurrentSnackBar,
          ),
        );
}

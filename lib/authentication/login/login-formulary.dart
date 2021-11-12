import 'package:flutter/material.dart';
import 'package:lab_movil_2222/authentication/login/login-form.model.dart';
import 'package:lab_movil_2222/authentication/login/login-user.service.dart';
import 'package:lab_movil_2222/authentication/register/register.screen.dart';
import 'package:lab_movil_2222/authentication/widgets/authentication-snackbar.dart';
import 'package:lab_movil_2222/city/ui/screen/home.screen.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/shared/forms/forms-validators.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:provider/provider.dart';

class LoginFormulary extends StatefulWidget {
  const LoginFormulary({
    Key? key,
    this.itemsSpacing = 15,
  }) : super(key: key);

  /// space used between form items
  final double itemsSpacing;

  @override
  _LoginFormularyState createState() => _LoginFormularyState();
}

class _LoginFormularyState extends State<LoginFormulary> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginFormModel _formValue = LoginFormModel.empty();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// formulario (falta aplicar backend)
          Text(
            'Continua tu aventura',
            style: textTheme.headline6,
            textAlign: TextAlign.center,
          ),

          /// spacer
          SizedBox(height: widget.itemsSpacing),

          /// email input
          TextFormField222(
            label: 'Correo Electrónico',
            keyboardType: TextInputType.emailAddress,
            onValueChanged: (email) => _formValue.email = email!,
            validator: FormValidators.email,
          ),

          /// spacer
          SizedBox(height: widget.itemsSpacing),

          TextFormField222.password(
            label: 'Contraseña',
            onValueChanged: (password) => _formValue.password = password!,
            validator: FormValidators.password,
          ),

          /// spacer
          SizedBox(height: widget.itemsSpacing),

          /// sign in button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors2222.black,
              elevation: 5,
            ),
            onPressed: _handleLogin,
            child: const Text('Ingresa y continua tu aventura!'),
          ),

          /// register
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, RegisterScreen.route),
            style: TextButton.styleFrom(primary: Colors2222.white),
            child: const Text('¿No tienes cuenta? Registrate aquí'),
          ),
        ],
      ),
    );
  }

  LoginService get _loginService =>
      Provider.of<LoginService>(context, listen: false);

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
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
        } else if (e.code == LoginErrorCode.invalidForm) {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.invalidForm(),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.somethingWentWrong(),
          );
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(
          const AuthenticationSnackbar.somethingWentWrong(),
        );
      }
    }
  }
}

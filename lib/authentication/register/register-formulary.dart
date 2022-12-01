import 'package:flutter/material.dart';
import 'package:lab_movil_2222/authentication/login/login.screen.dart';
import 'package:lab_movil_2222/authentication/register/register-form.model.dart';
import 'package:lab_movil_2222/authentication/register/register-user.service.dart';
import 'package:lab_movil_2222/authentication/widgets/authentication-snackbar.dart';
import 'package:lab_movil_2222/home-map/ui/screen/home.screen.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/shared/forms/forms-validators.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:provider/provider.dart';

/// formulary used to obtain players information
class RegisterFormulary extends StatefulWidget {
  const RegisterFormulary({
    Key? key,
    this.itemsSpacing = 15,
  }) : super(key: key);

  static const String route = '/register';

  /// space used between form items
  final double itemsSpacing;

  @override
  _RegisterFormularyState createState() => _RegisterFormularyState();
}

class _RegisterFormularyState extends State<RegisterFormulary> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RegisterFormModel _formValue = RegisterFormModel.empty();

  RegisterService get _registerService =>
      Provider.of<RegisterService>(context, listen: false);

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// form title
          Text(
            'Comienza tu aventura',
            style: textTheme.headline6,
            textAlign: TextAlign.center,
          ),

          /// spacer
          SizedBox(height: widget.itemsSpacing),

          /// email input
          TextFormField222(
            label: 'Correo Electrónico',
            keyboardType: TextInputType.emailAddress,
            onValueChanged: (email) => _formValue.email = email,
            validator: FormValidators.email,
          ),

          /// spacer
          SizedBox(height: widget.itemsSpacing),

          /// password
          TextFormField222.password(
            label: 'Contraseña',
            onValueChanged: (pass) => _formValue.password = pass,
            validator: FormValidators.password,
          ),

          /// spacer
          SizedBox(height: widget.itemsSpacing),

          /// validate password
          TextFormField222.password(
            label: 'Validar Contraseña',
            onValueChanged: (pass) => _formValue.passwordMatch = pass,
            validator: (newPass) =>
                FormValidators.passwordsMatch(newPass, _formValue.password),
          ),

          /// spacer
          SizedBox(height: widget.itemsSpacing),

          /// register button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors2222.black,
              elevation: 5,
            ),
            onPressed: _register,
            child: const Text('Crea una cuenta y comienza tu aventura!'),
          ),

          /// already have an account button
          ///
          /// back button to replace current screen with login screen
          TextButton(
            child: const Text('¿Ya tienes una cuenta? Inicia Sesión!'),
            style: TextButton.styleFrom(primary: Colors2222.white),
            onPressed: () =>
                Navigator.pushReplacementNamed(context, LoginScreen.route),
          ),
        ],
      ),
    );
  }

  /// internal logic to register a new player
  Future<void> _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      try {
        final PlayerModel createdPlayer =
            await _registerService.register(_formValue);

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
            const AuthenticationSnackbar.accountNotRegistered(),
          );
        } else if (e.code == RegisterErrorCode.notInscribed) {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.notInscribed(),
          );
        } else if (e.code == RegisterErrorCode.weakPassword) {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.weakPassword(),
          );
        } else if (e.code == RegisterErrorCode.invalidForm) {
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

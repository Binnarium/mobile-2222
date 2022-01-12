import 'package:flutter/material.dart';
import 'package:lab_movil_2222/authentication/login/login.screen.dart';
import 'package:lab_movil_2222/authentication/recover-password/recover-password-form.model.dart';
import 'package:lab_movil_2222/authentication/recover-password/recover-password.service.dart';
import 'package:lab_movil_2222/authentication/widgets/authentication-snackbar.dart';
import 'package:lab_movil_2222/shared/forms/forms-validators.dart';
import 'package:lab_movil_2222/themes/colors.dart';
import 'package:lab_movil_2222/widgets/form/text-form-field-2222.widget.dart';
import 'package:provider/provider.dart';

class RecoverPasswordFormulary extends StatefulWidget {
  const RecoverPasswordFormulary({
    Key? key,
    this.itemsSpacing = 15,
  }) : super(key: key);

  /// space used between form items
  final double itemsSpacing;

  @override
  _RecoverPasswordFormularyState createState() =>
      _RecoverPasswordFormularyState();
}

class _RecoverPasswordFormularyState extends State<RecoverPasswordFormulary> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final RecoverPasswordFormModel _formValue = RecoverPasswordFormModel.empty();

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          /// formulario (falta aplicar backend)
          Text(
            'Recuperación de Contraseña',
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

          /// sign in button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors2222.black,
              elevation: 5,
            ),
            onPressed: _handleRecoverPassword,
            child: const Text('Recupera tu contraseña!'),
          ),

          /// register
          TextButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, LoginScreen.route),
            style: TextButton.styleFrom(primary: Colors2222.white),
            child: const Text('Volver al Ingreso'),
          ),
        ],
      ),
    );
  }

  RecoveryPasswordService get _recoveryPasswordService =>
      Provider.of<RecoveryPasswordService>(context, listen: false);

  Future<void> _handleRecoverPassword() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await _recoveryPasswordService.sendRecoverEmail(_formValue);
        ScaffoldMessenger.of(context).showSnackBar(
          AuthenticationSnackbar.successRecover(context: context),
        );
      } on RecoveryPasswordException catch (e) {
        if (e.code == RecoverPasswordErrorCode.invalidEmail) {
          ScaffoldMessenger.of(context).showSnackBar(
            const AuthenticationSnackbar.invalidEmail(),
          );
        } else if (e.code == RecoverPasswordErrorCode.userNotFound) {
          ScaffoldMessenger.of(context).showSnackBar(
            AuthenticationSnackbar.notRegistered(context: context),
          );
        } else if (e.code == RecoverPasswordErrorCode.invalidForm) {
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

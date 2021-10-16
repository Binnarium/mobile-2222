import 'package:lab_movil_2222/shared/pipes/string-validators.extension.dart';

mixin FormValidators {
  static String? passwordsMatch(String? newPassword, String? oldPassword) =>
      oldPassword != newPassword ? 'Las contraseñas no coinciden' : null;

  static String? password(String? value) {
    final PasswordValidity? validPassword = value?.validPassword();
    if (validPassword == null || validPassword == PasswordValidity.empty) {
      return 'Ingresa una contraseña valida';
    }
    if (validPassword == PasswordValidity.tooShort) {
      return 'La contraseña es muy corta';
    }
    return null;
  }

  /// form validator to check for a valid email format
  static String? email(String? email) =>
      email?.validEmail() ?? false ? null : 'Correo electrónico invalido';
}

class RegisterFormModel {
  String email;
  String password;
  String validatePassword;

  RegisterFormModel.empty()
      : email = '',
        password = '',
        validatePassword = '';
}

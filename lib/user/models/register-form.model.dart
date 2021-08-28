class RegisterFormModel {
  String email;
  String password;
  String validatePassword;

  RegisterFormModel.empty()
      : this.email = '',
        this.password = '',
        this.validatePassword = '';
}

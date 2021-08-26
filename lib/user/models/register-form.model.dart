class RegisterFormModel {
  String? email;
  String? password;
  String? validatePassword;

  RegisterFormModel.empty()
      : this.email = null,
        this.password = null,
        this.validatePassword = null;
}

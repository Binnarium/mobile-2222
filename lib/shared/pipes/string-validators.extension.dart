enum PasswordValidity {
  valid,
  tooShort,
  empty,
}

extension StringValidators on String {
  bool validEmail() {
    final RegExp emailPattern =
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');
    final bool emailValid = emailPattern.hasMatch(this);
    return emailValid;
  }

  PasswordValidity validPassword() {
    const int numberCharacters = 6;
    if (this == null || isEmpty) {
      return PasswordValidity.empty;
    }
    if (length < numberCharacters) {
      return PasswordValidity.tooShort;
    }
    return PasswordValidity.valid;
  }
}

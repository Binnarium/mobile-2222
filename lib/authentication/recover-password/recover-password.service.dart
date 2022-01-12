import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/authentication/recover-password/recover-password-form.model.dart';

enum RecoverPasswordErrorCode {
  userNotFound,
  invalidEmail,
  invalidForm,
  other,
}

class RecoveryPasswordException implements Exception {
  RecoveryPasswordException(this.code);
  RecoverPasswordErrorCode code;
}

class RecoveryPasswordService {
  RecoveryPasswordService() : _fAuth = FirebaseAuth.instance;

  final FirebaseAuth _fAuth;

  Future<void> sendRecoverEmail(RecoverPasswordFormModel formModel) async {
    if (formModel.email == null) {
      throw RecoveryPasswordException(RecoverPasswordErrorCode.invalidForm);
    }

    try {
      await _fAuth.sendPasswordResetEmail(email: formModel.email!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw RecoveryPasswordException(RecoverPasswordErrorCode.invalidEmail);
      }

      if (e.code == 'user-not-found') {
        throw RecoveryPasswordException(RecoverPasswordErrorCode.userNotFound);
      }

      /// unhandled firebase error
      print(e.code);
      throw RecoveryPasswordException(RecoverPasswordErrorCode.other);
    }
  }
}

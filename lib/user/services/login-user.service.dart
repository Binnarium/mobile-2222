import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/models/player.dto.dart';
import 'package:lab_movil_2222/user/models/login-form.model.dart';

enum LoginErrorCode {
  playerNotFound,
  userDisabled,
  userNotFound,
  wrongPassword,
  invalidEmail,
  other,
}

class LoginException implements Exception {
  LoginErrorCode code;
  LoginException(this.code);
}

abstract class ILoginService {
  Future<PlayerDto> login(LoginFormModel formModel);
}

class LoginService extends ILoginService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  @override
  Future<PlayerDto> login(LoginFormModel formModel) async {
    final User user = await this._signIn(
      formModel.email,
      formModel.password,
    );

    final payload =
        await this._fFirestore.collection('players').doc(user.uid).get();

    if (!payload.exists) throw LoginException(LoginErrorCode.playerNotFound);
    return PlayerDto.fromMap(payload.data()!);
  }

  Future<User> _signIn(String email, String password) async {
    try {
      UserCredential credentials = await this._fAuth.signInWithEmailAndPassword(
            email: email,
            password: password,
          );

      if (credentials.user == null)
        throw LoginException(LoginErrorCode.userNotFound);

      return credentials.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email')
        throw LoginException(LoginErrorCode.invalidEmail);

      if (e.code == 'user-disabled')
        throw LoginException(LoginErrorCode.userDisabled);

      if (e.code == 'user-not-found')
        throw LoginException(LoginErrorCode.userNotFound);

      if (e.code == 'wrong-password')
        throw LoginException(LoginErrorCode.wrongPassword);

      /// unhandled firebase error
      print(e.code);
      throw LoginException(LoginErrorCode.other);
    }
  }
}

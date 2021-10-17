import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/authentication/login/login-form.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';

enum LoginErrorCode {
  playerNotFound,
  userDisabled,
  userNotFound,
  wrongPassword,
  invalidEmail,
  invalidForm,
  other,
}

class LoginException implements Exception {
  LoginException(this.code);
  LoginErrorCode code;
}

class LoginService {
  LoginService()
      : _fAuth = FirebaseAuth.instance,
        _fFirestore = FirebaseFirestore.instance;

  final FirebaseAuth _fAuth;
  final FirebaseFirestore _fFirestore;

  Future<PlayerModel> login(LoginFormModel formModel) async {
    if (formModel.email == null || formModel.password == null) {
      throw LoginException(LoginErrorCode.invalidForm);
    }

    final User user = await _signIn(
      formModel.email!,
      formModel.password!,
    );

    final payload = await _fFirestore.collection('players').doc(user.uid).get();

    if (!payload.exists) {
      throw LoginException(LoginErrorCode.playerNotFound);
    }

    return PlayerModel.fromMap(payload.data()!);
  }

  Future<User> _signIn(String email, String password) async {
    try {
      final UserCredential credentials =
          await _fAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credentials.user == null) {
        throw LoginException(LoginErrorCode.userNotFound);
      }

      return credentials.user!;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        throw LoginException(LoginErrorCode.invalidEmail);
      }

      if (e.code == 'user-disabled') {
        throw LoginException(LoginErrorCode.userDisabled);
      }

      if (e.code == 'user-not-found') {
        throw LoginException(LoginErrorCode.userNotFound);
      }

      if (e.code == 'wrong-password') {
        throw LoginException(LoginErrorCode.wrongPassword);
      }

      /// unhandled firebase error
      print(e.code);
      throw LoginException(LoginErrorCode.other);
    }
  }
}

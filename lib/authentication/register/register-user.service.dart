import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/authentication/register/register-form.model.dart';
import 'package:lab_movil_2222/authentication/register/registered-player.model.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';

enum RegisterErrorCode {
  notInscribed,
  emailAlreadyInUse,
  notCreated,
  weakPassword,
  invalidForm,
  other,
}

class RegisterException implements Exception {
  RegisterException(this.code);
  RegisterErrorCode code;
}

class RegisterService {
  RegisterService()
      : _fAuth = FirebaseAuth.instance,
        _fFirestore = FirebaseFirestore.instance;

  final FirebaseAuth _fAuth;
  final FirebaseFirestore _fFirestore;

  /// function to register a player to the application
  ///
  /// A [RegisterException] maybe thrown
  Future<PlayerModel> register(RegisterFormModel formModel) async {
    if (formModel.email == null || formModel.password == null) {
      throw RegisterException(RegisterErrorCode.invalidForm);
    }

    /// get player inscription information
    final PlayerInscription playerInscribed =
        await _getUserInscription(formModel.email!);

    /// create account
    final User user =
        await _createAccount(formModel.email!, formModel.password!);

    /// create player
    final Map<String, dynamic> newPlayerMap = createNewPlayerMap(
      uid: user.uid,
      displayName: '${playerInscribed.name} ${playerInscribed.lastName}',
      email: formModel.email!,
      playerType: playerInscribed.playerType,
    );

    final PlayerModel newPlayer = await _createPlayer(user.uid, newPlayerMap);

    /// return new created player
    return newPlayer;
  }

  /// get the inscription information of a player
  ///
  /// If no inscription registry found,
  /// throws a [RegisterException] with the [RegisterErrorCode.notInscribed]
  Future<PlayerInscription> _getUserInscription(String email) async {
    final payload =
        await _fFirestore.collection('inscribed-players').doc(email).get();

    if (!payload.exists) {
      throw RegisterException(RegisterErrorCode.notInscribed);
    }

    final Map<String, dynamic> data = payload.data()!;
    return PlayerInscription.fromMap(data);
  }

  /// add player to database
  Future<PlayerModel> _createPlayer(
      String uid, Map<String, dynamic> player) async {
    try {
      await _fFirestore.collection('players').doc(uid).set(player);

      /// get player data from firebase
      final PlayerModel newPlayer = PlayerModel.fromMap(player);
      return newPlayer;
    } catch (e) {
      print(e);
      throw RegisterException(RegisterErrorCode.other);
    }
  }

  /// create account thought firebase authentication
  ///
  /// Create account with email and password
  Future<User> _createAccount(String email, String password) async {
    UserCredential? credentials;

    try {
      credentials = await _fAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        throw RegisterException(RegisterErrorCode.emailAlreadyInUse);
      }

      if (e.code == 'weak-password') {
        throw RegisterException(RegisterErrorCode.weakPassword);
      }

      /// unhandled firebase error
      print(e.code);
      throw RegisterException(RegisterErrorCode.other);
    }

    if (credentials.user == null) {
      throw RegisterException(RegisterErrorCode.notCreated);
    }
    return credentials.user!;
  }
}

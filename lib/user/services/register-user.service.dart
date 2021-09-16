import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';
import 'package:lab_movil_2222/user/models/register-form.model.dart';
import 'package:lab_movil_2222/user/models/registered-player.model.dart';

enum RegisterErrorCode {
  notInscribed,
  emailAlreadyInUse,
  notCreated,
  weakPassword,
  other,
}

/// TODO: add docs
class RegisterException implements Exception {
  RegisterErrorCode code;
  RegisterException(this.code);
}

abstract class IRegisterService {
  /// function to register a player to the application
  ///
  /// A [RegisterException] maybe thrown
  Future<PlayerModel> register(RegisterFormModel formModel);
}

/// register implementation using firebase services
class RegisterService extends IRegisterService {
  final FirebaseAuth _fAuth = FirebaseAuth.instance;
  final FirebaseFirestore _fFirestore = FirebaseFirestore.instance;

  @override
  Future<PlayerModel> register(RegisterFormModel formModel) async {
    /// get player inscription information
    final PlayerInscription playerInscribed =
        await _getInscription(formModel.email);

    /// create account
    final User user = await _createAccount(formModel.email, formModel.password);

    /// create new player account
    final PlayerModel newPlayer = PlayerModel.empty(
      uid: user.uid,
      displayName: '${playerInscribed.name} ${playerInscribed.lastName}',
      email: formModel.email,
    );

    /// create player
    await _createPlayer(newPlayer);

    /// return new created player
    return newPlayer;
  }

  /// check for a inscribed player registry at the collection
  Future<PlayerInscription> _getInscription(String email) async {
    final payload =
        await _fFirestore.collection('inscribed-players').doc(email).get();

    if (!payload.exists) {
      throw RegisterException(RegisterErrorCode.notInscribed);
    }

    return PlayerInscription(
      email: payload.data()!['email'] as String,
      lastName: payload.data()!['lastName'] as String,
      name: payload.data()!['name'] as String,
    );
  }

  /// add player to database
  Future<void> _createPlayer(PlayerModel player) async {
    try {
      await _fFirestore
          .collection('players')
          .doc(player.uid)
          .set(player.toMap());
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

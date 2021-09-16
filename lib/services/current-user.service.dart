import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lab_movil_2222/player/models/player.model.dart';

class UserService {
  final FirebaseAuth _firebaseAuth;

  static UserService? _instance;

  UserService._() : _firebaseAuth = FirebaseAuth.instance;

  static UserService get instance {
    UserService._instance ??= UserService._();
    return UserService._instance!;
  }

  Stream<bool> isSignIn$() {
    return Stream.value(_firebaseAuth.currentUser)
        .take(1)
        .map((user) => user != null);
  }

  bool isSignIn() {
    return _firebaseAuth.currentUser != null;
  }

  Stream<User?> user$() {
    return Future<dynamic>.delayed(Duration(seconds: 1))
        .asStream()
        .map((dynamic _) => _firebaseAuth.currentUser);
  }

  /// TODO: move to correct file
  /// TODO: refactor
  Stream<PlayerModel?> player$() {
    return user$().asyncMap((event) async {
      print(event);
      if (event == null) return null;

      final payload = await FirebaseFirestore.instance
          .collection('players')
          .doc(event.uid)
          .get();

      if (!payload.exists) return null;
      return PlayerModel.fromMap(payload.data()!);
    });
  }

  Stream<bool> signIn$(String email, String password) {
    final Stream<bool> signInTask = _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .asStream()
        .map((_) => true)
        .handleError((dynamic error) {
      print(error);
      return false;
    });

    return signInTask;
  }

  Stream<bool> signOut$() {
    final Stream<bool> signOutTask = _firebaseAuth
        .signOut()
        .asStream()
        .map((_) => true)
        .handleError((dynamic error) {
      print(error);
      return false;
    });

    return signOutTask;
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class UserService {
  final FirebaseAuth _firebaseAuth;

  static UserService? _instance;

  UserService._() : this._firebaseAuth = FirebaseAuth.instance;

  static UserService get instance {
    if (UserService._instance == null) {
      UserService._instance = UserService._();
    }
    return UserService._instance!;
  }

  Stream<bool> isSignIn$() {
    return Future.delayed(Duration(seconds: 5))
        .asStream()
        .map((_) => this._firebaseAuth.currentUser)
        .take(1)
        .map((user) => user != null);
  }

  Stream<User?> userUID$() {
    return Future.delayed(Duration(seconds: 1))
        .asStream()
        .map((_) => this._firebaseAuth.currentUser)
        .take(1);
  }

  Stream<bool> signIn$(String email, String password) {
    final Stream<bool> signInTask = this
        ._firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .asStream()
        .map((_) => true)
        .handleError((error) {
      print(error);
      return false;
    });

    return signInTask;
  }

  Stream<bool> signOut$() {
    final Stream<bool> signOutTask = this
        ._firebaseAuth
        .signOut()
        .asStream()
        .map((_) => true)
        .handleError((error) {
      print(error);
      return false;
    });

    return signOutTask;
  }
}

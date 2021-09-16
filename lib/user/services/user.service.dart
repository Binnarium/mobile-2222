import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

/// access authenticated user information, and credentials
class UserService {
  UserService() : _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;

  Stream<User?> get user$ =>
      _auth.authStateChanges().map((user) => null).shareReplay();

  Stream<bool> get isSignIn$ => user$.take(1).map((user) => user != null);
}

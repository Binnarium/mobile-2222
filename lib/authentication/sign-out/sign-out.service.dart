import 'package:firebase_auth/firebase_auth.dart';

/// Sign Out
class SignOutService {
  SignOutService() : _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;

  Stream<void> signOut$() {
    return Stream.fromFuture(_auth.signOut());
  }
}

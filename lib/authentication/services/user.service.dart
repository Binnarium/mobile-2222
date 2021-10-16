import 'package:firebase_auth/firebase_auth.dart';

/// access authenticated user information, and credentials
class IsUserSignInService {
  IsUserSignInService() : _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;

  Stream<bool> get isSignIn$ => Future.delayed(
        const Duration(milliseconds: 100),
        () => _auth.currentUser != null,
      ).asStream();
}

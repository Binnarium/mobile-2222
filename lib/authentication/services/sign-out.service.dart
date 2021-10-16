import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Sign Out
class SignOutService {
  SignOutService(BuildContext context) : _auth = FirebaseAuth.instance;

  final FirebaseAuth _auth;

  Stream<void> signOut$() {
    return Stream.fromFuture(_auth.signOut());
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Sign Out
class SignOutService {
  final FirebaseAuth _auth;

  SignOutService(BuildContext context) : _auth = FirebaseAuth.instance;

  Stream<void> signOut$() {
    return Stream.fromFuture(_auth.signOut());
  }
}

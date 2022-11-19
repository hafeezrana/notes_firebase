import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notesAuthProvider = Provider<AuthService>((ref) {
  return AuthService();
});

//const noUser = User();

class AuthUser {
  const AuthUser({
    required this.uid,
    required this.displayName,
  });

  static const empty = AuthUser(uid: '', displayName: 'Empty');

  final String uid;
  final String displayName;
}

class AuthService {
  final _instance = FirebaseAuth.instance;

  Stream<AuthUser> get authStateChanges =>
      _instance.authStateChanges().map(_mapAuthUser).asBroadcastStream();

  AuthUser get authUser => _mapAuthUser(_instance.currentUser);

  AuthUser _mapAuthUser(User? user) {
    if (user == null) {
      return AuthUser.empty;
    } else {
      return AuthUser(
        uid: user.uid,
        displayName: user.displayName ?? '',
      );
    }
  }

  Future<UserCredential> createUser({
    required String email,
    required String password,
  }) {
    return _instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> loginIn({
    required String email,
    required String password,
  }) {
    return _instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() {
    return _instance.signOut();
  }
}

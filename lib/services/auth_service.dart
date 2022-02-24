import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _instance = FirebaseAuth.instance;
  Stream<User?> get authStateChanges => _instance.authStateChanges();
  String get userId => _instance.currentUser!.uid;

  Future<UserCredential> createUser({
    required String email,
    required String password,
  }) {
    return _instance.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> loginIn({
    required String email,
    required String password,
  }) {
    return _instance.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signOut() {
    return _instance.signOut();
  }
}

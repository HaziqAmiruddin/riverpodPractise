import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus { loading, authenticated, unauthenticated }

final authControllerProvider =
    StreamNotifierProvider<AuthController, AuthStatus>(AuthController.new);

class AuthController extends StreamNotifier<AuthStatus> {
  late final FirebaseAuth _auth;

  @override
  Stream<AuthStatus> build() {
    _auth = FirebaseAuth.instance;

    return _auth.authStateChanges().map((user) {
      if (user == null) {
        return AuthStatus.unauthenticated;
      } else {
        return AuthStatus.authenticated;
      }
    });
  }

  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() async {
    await _auth.signOut();
  }

  Future<void> register(String email, String password) async {
    await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDatasource {
  final FirebaseAuth auth;

  FirebaseAuthDatasource(this.auth);

  Stream<User?> authStateChanges() => auth.authStateChanges();

  Future<UserCredential> login(String email, String password) {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> logout() => auth.signOut();
}

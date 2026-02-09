import 'package:river_pod_practise/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:river_pod_practise/features/auth/domain/entities/auth_user.dart';
import 'package:river_pod_practise/features/auth/domain/repository/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuthDatasource datasource;

  AuthRepositoryImpl(this.datasource);

  @override
  Stream<AuthUser?> authStateChanges() {
    return datasource.authStateChanges().map((user) {
      if (user == null) return null;
      return AuthUser(id: user.uid, email: user.email ?? '');
    });
  }

  @override
  Future<AuthUser> login(String email, String password) async {
    final cred = await datasource.login(email, password);
    final user = cred.user!;

    return AuthUser(id: user.uid, email: user.email ?? '');
  }

  @override
  Future<void> logout() => datasource.logout();
}

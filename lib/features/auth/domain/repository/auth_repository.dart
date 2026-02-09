import 'package:river_pod_practise/features/auth/domain/entities/auth_user.dart';

abstract class AuthRepository {
  Stream<AuthUser?> authStateChanges();
  Future<AuthUser> login(String email, String password);
  Future<void> logout();
}

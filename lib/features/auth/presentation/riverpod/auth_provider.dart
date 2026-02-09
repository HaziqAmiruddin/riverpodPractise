import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_practise/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:river_pod_practise/features/auth/data/repository/auth_repository_data.dart';
import 'package:river_pod_practise/features/auth/domain/repository/auth_repository.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>(
  (ref) => FirebaseAuth.instance,
);

final authDatasourceProvider = Provider(
  (ref) => FirebaseAuthDatasource(ref.read(firebaseAuthProvider)),
);

final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => AuthRepositoryImpl(ref.read(authDatasourceProvider)),
);

import 'package:river_pod_practise/features/home_page/data/datasources/user_datasource.dart';
import 'package:river_pod_practise/features/home_page/domain/entities/user.dart';
import 'package:river_pod_practise/features/home_page/domain/repositories/user_repository.dart';

class UserRepositoryImpldata implements UserRepository {
  final UserDatasource remote;

  UserRepositoryImpldata(this.remote);

  @override
  Future<List<User>> getUsers() async {
    return await remote.getUsers();
  }
}

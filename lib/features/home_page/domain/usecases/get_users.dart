import 'package:river_pod_practise/features/home_page/domain/entities/user.dart';
import 'package:river_pod_practise/features/home_page/domain/repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<List<User>> call() async {
    return await repository.getUsers();
  }
}

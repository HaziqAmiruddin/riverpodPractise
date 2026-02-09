import 'package:river_pod_practise/features/home_page/domain/entities/user.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
}

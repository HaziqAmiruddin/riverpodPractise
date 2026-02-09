import 'package:dio/dio.dart';
import 'package:river_pod_practise/features/home_page/data/models/user_modal.dart';

class UserDatasource {
  final Dio dio;

  UserDatasource(this.dio);

  Future<List<UserModal>> getUsers() async {
    final response = await dio.get(
      "https://jsonplaceholder.typicode.com/users",
    );

    return (response.data as List)
        .map((json) => UserModal.fromJson(json))
        .toList();
  }
}

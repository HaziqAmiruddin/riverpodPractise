import 'package:dio/dio.dart';
import 'package:river_pod_practise/features/task/data/models/task_todo_modal.dart';

class TodoDatasource {
  final Dio dio;

  TodoDatasource(this.dio);

  Future<List<TaskTodoModal>> fetchTodoTasks(int page) async {
    final response = await dio.get(
      'https://jsonplaceholder.typicode.com/todos',
      queryParameters: {"_page": page, "_limit": 20},
    );

    if (response.data is! List) {
      throw Exception("Invalid server response");
    }

    final List data = response.data as List;
    return data.map((e) => TaskTodoModal.fromJson(e)).toList();
  }
}

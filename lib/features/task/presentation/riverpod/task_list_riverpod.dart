import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_practise/core/network/dio_provider.dart';
import 'package:river_pod_practise/features/task/data/datasource/todo_datasource.dart';
import 'package:river_pod_practise/features/task/domain/entities/task_todo.dart';
import 'package:river_pod_practise/features/task/presentation/riverpod/task_list_notifier.dart';

// final dioProvider = Provider((ref) {
//   final dio = Dio();

//   dio.options.headers = {
//     'Accept': 'application/json',
//     'Content-Type': 'application/json',
//     'User-Agent': 'Mozilla/5.0',
//   };

//   return dio;
// });

final TodoDataSourceProvider = Provider(
  (ref) => TodoDatasource(ref.read(dioProvider)),
);

final TodoListProvider =
    AsyncNotifierProvider<TaskListNotifier, List<TaskTodo>>(
      TaskListNotifier.new,
    );

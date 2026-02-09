import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:river_pod_practise/features/task/domain/entities/task_todo.dart';
import 'package:river_pod_practise/features/task/presentation/riverpod/task_list_riverpod.dart';

class TaskListNotifier extends AsyncNotifier<List<TaskTodo>> {
  int _page = 1;
  bool _hasMore = true;
  bool _isLoadingMore = false;

  @override
  Future<List<TaskTodo>> build() async {
    _page = 1;
    _hasMore = true;
    return _fetchPage();
  }

  Future<List<TaskTodo>> _fetchPage() async {
    final datasource = ref.read(TodoDataSourceProvider);
    final tasks = await datasource.fetchTodoTasks(_page);

    if (tasks.isEmpty) _hasMore = false;
    return tasks;
  }

  /// LOAD MORE (Infinite Scroll)
  Future<void> loadMore() async {
    if (!_hasMore || _isLoadingMore || state.isLoading) return;

    _isLoadingMore = true;
    _page++;

    try {
      final moreTasks = await ref
          .read(TodoDataSourceProvider)
          .fetchTodoTasks(_page);

      if (moreTasks.isEmpty) {
        _hasMore = false;
        return;
      }

      final current = state.value ?? [];
      state = AsyncData([...current, ...moreTasks]);
    } catch (e, st) {
      state = AsyncError(e, st);
    }

    _isLoadingMore = false;
  }

  /// Pull To Refresh
  Future<void> refresh() async {
    _page = 1;
    _hasMore = true;

    state = const AsyncLoading();

    state = await AsyncValue.guard(() => _fetchPage());
  }
}

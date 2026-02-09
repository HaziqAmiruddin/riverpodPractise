import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:river_pod_practise/features/task/presentation/riverpod/task_list_riverpod.dart';

class TaskListScreen extends ConsumerStatefulWidget {
  const TaskListScreen({super.key});

  @override
  ConsumerState<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends ConsumerState<TaskListScreen> {
  final scrollCtrl = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollCtrl.addListener(_onScroll);
  }

  void _onScroll() {
    if (!scrollCtrl.hasClients) return;

    final threshold = scrollCtrl.position.maxScrollExtent * 0.8;

    if (scrollCtrl.position.pixels > threshold) {
      ref.read(TodoListProvider.notifier).loadMore();
    }
  }

  @override
  void dispose() {
    scrollCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tasksAsync = ref.watch(TodoListProvider);

    return Scaffold(
      appBar: AppBar(title: Text("Phase 2"), centerTitle: true),
      body: tasksAsync.when(
        data: (todos) => RefreshIndicator(
          onRefresh: () => ref.read(TodoListProvider.notifier).refresh(),
          child: ListView.builder(
            itemBuilder: (context, index) {
              final task = todos[index];

              return ListTile(
                leading: CircleAvatar(child: Text(task.id.toString())),
                title: Text(task.title),
                subtitle: Text("User ${task.userId}"),
                trailing: Icon(
                  task.completed ? Icons.check_circle : Icons.circle_outlined,
                  color: task.completed ? Colors.green : Colors.grey,
                ),
              );
            },
            controller: scrollCtrl,
            itemCount: todos.length,
          ),
        ),
        error: (error, stackTrace) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Something Went Wrong\n$error"),
              ElevatedButton(
                onPressed: () => ref.refresh(TodoListProvider),
                child: const Text("Retry"),
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

import 'package:river_pod_practise/features/task/domain/entities/task_todo.dart';

class TaskTodoModal extends TaskTodo {
  TaskTodoModal({
    required super.userId,
    required super.id,
    required super.title,
    required super.completed,
  });

  factory TaskTodoModal.fromJson(Map<String, dynamic> json) {
    return TaskTodoModal(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      completed: json['completed'],
    );
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'id': id,
    'title': title,
    'completed': completed,
  };
}

import 'package:flutter/foundation.dart';

void main() {
  Map<int, List<String>> prioTizedTask = groupAndSortTasksByPriority(mockTasks);
  debugPrint("=============================> $prioTizedTask");
}

Map<int, List<String>> groupAndSortTasksByPriority(List<Task> tasks) {
  final Map<int, List<Task>> groupedTasks = {};
  for (var task in tasks) {
    groupedTasks.putIfAbsent(task.priority, () => []).add(task);
  }

  final result = groupedTasks.map((priority, tasks) {
    tasks.sort((a, b) => a.deadline.compareTo(b.deadline));
    return MapEntry(priority, tasks.map((task) => task.name).toList());
  });

  return result;
}

  List<Task> mockTasks = [
    Task(name: 'Task A', priority: 1, deadline: DateTime(2024, 11, 21)),
    Task(name: 'Task B', priority: 2, deadline: DateTime(2024, 11, 20)),
    Task(name: 'Task C', priority: 1, deadline: DateTime(2024, 11, 19)),
  ];
class Task {
  final String name;
  final int priority;
  final DateTime deadline;

  Task({required this.name, required this.priority, required this.deadline});
}

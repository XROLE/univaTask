import 'package:flutter_test/flutter_test.dart';
import 'package:univa_task/task_2/task_2.dart';

void main() {
  test('groupAndSortTasksByPriority groups and sorts tasks correctly', () {
    final result = groupAndSortTasksByPriority(mockTasks);

    expect(result, {
      1: ['Task C', 'Task A'],
      2: ['Task B'],
    });
  });
}
import 'package:univa_task/data/model/task_model.dart';

abstract class TaskService {
  Future<List<Task>>? fetchTasks();
}

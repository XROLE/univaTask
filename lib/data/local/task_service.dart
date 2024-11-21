import 'package:univa_task/data/model/task_model.dart';

abstract class TaskCacheService {
  Future<void> cacheTask(List<Task> tasks);
  Future<List<Task>> retrieveCachedTasks();
}

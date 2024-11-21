import 'package:hive/hive.dart';
import 'package:univa_task/data/local/task_service.dart';
import 'package:univa_task/data/model/task_model.dart';
import 'package:univa_task/utils/constants/constants.dart';

class TaskCacheServiceImpl implements TaskCacheService {
  final _taskBox = Hive.box(Constants.taskBox);

  @override
  Future<void> cacheTask(List<Task> tasks) async {
    await _taskBox.put(Constants.tasks, tasks);
  }

  @override
  Future<List<Task>> retrieveCachedTasks() async {
    List<Task> tasks = [];
    var res = await _taskBox.get(Constants.tasks);
    if (res != null) {
      for (int i = 0; i < res.length; i++) {
        tasks.add(res[i]);
      }
    }
    return tasks;
  }
}

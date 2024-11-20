import 'package:univa_task/app/core/client/http_client.dart';
import 'package:univa_task/app/core/endpoint/endpoints.dart';
import 'package:univa_task/data/model/task_model.dart';
import 'package:univa_task/data/remote/task_service.dart';

class TaskServiceImpl implements TaskService {
  final CustomHttpClient httpClient;
  TaskServiceImpl(this.httpClient);
  @override
  Future<List<Task>>? fetchTasks() async {
    var res = await httpClient.get(url: Endpoints.tasksUrl, headers: {});
    List rawTask = res?.data as List;

    List<Task> trTask = rawTask.map((el) => Task.fromJson(el)).toList();
    return trTask;
  }
}

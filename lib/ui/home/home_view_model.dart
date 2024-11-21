import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:univa_task/app/core/failure/failure.dart';
import 'package:univa_task/data/local/task_service.dart';
import 'package:univa_task/data/model/task_model.dart';
import 'package:univa_task/data/remote/task_service.dart';
import 'package:univa_task/ui/base/base_view_model.dart';
import 'package:univa_task/utils/constants/error_text.dart';

class HomeViewModel extends BaseViewModel {
  final TaskService taskService;
  final TaskCacheService taskCacheService;
  HomeViewModel({required this.taskService, required this.taskCacheService});

  bool _isFetchingTasks = true;
  bool get isFetchingTasks => _isFetchingTasks;
  set isFetchingTasks(bool val) {
    _isFetchingTasks = val;
    notifyListeners();
  }

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;
  set tasks(List<Task> val) {
    _tasks = val;
    notifyListeners();
  }

  Future<void> fetchTasks(
      {required Function(String e) onError,
      required Function(List<Task> taskss) onSuccess}) async {
    try {
      isFetchingTasks = true;
      var res = await taskService.fetchTasks();
      if (res != null) {
        tasks = res;
        onSuccess(res);
      }
      isFetchingTasks = false;
    } on Failure catch (e) {
      isFetchingTasks = false;
      onError(e.errorMessage);
      debugPrint(
          "Error Failure ============================> ${e.errorMessage}");
    } catch (e) {
      isFetchingTasks = false;
      onError(ErrorText.generic);
      debugPrint("Error Failure ============================> $e.");
    }
  }

  Future<List<Task>> loadCachedTasks() async {
    try {
      List<Task> res = await taskCacheService.retrieveCachedTasks();
      return res;
    } catch (e) {
      debugPrint("Error loading task from cache ==============> $e");
      return [];
    }
  }

  Future<void> cachedTasks(List<Task> task) async {
    try {
      await taskCacheService.cacheTask(task);
      debugPrint("Task cached successfuly =======================> ");
    } catch (e) {
      debugPrint("Error caching task in hive ==============> $e");
    }
  }
}

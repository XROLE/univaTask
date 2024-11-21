import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univa_task/data/local/task_service.dart';
import 'package:univa_task/data/model/task_model.dart';
import 'package:univa_task/data/remote/task_service.dart';
import 'package:univa_task/app/core/failure/failure.dart';
import 'package:univa_task/ui/home/home_view_model.dart';

class MockTaskService extends Mock implements TaskService {}

class MockTaskCacheService extends Mock implements TaskCacheService {}

void main() {
  late HomeViewModel homeViewModel;
  late MockTaskService mockTaskService;
  late MockTaskCacheService mockTaskCacheService;

  setUp(() {
    mockTaskService = MockTaskService();
    mockTaskCacheService = MockTaskCacheService();
    homeViewModel = HomeViewModel(
      taskService: mockTaskService,
      taskCacheService: mockTaskCacheService,
    );
  });

  group('HomeViewModel Tests', () {
    test('should set isFetchingTasks to true when fetching tasks', () async {
      when(() => mockTaskService.fetchTasks()).thenAnswer(
        (_) async => [
          Task(id: 1, title: 'Test Task', completed: false),
        ],
      );

      bool? isFetchingTasksBefore = homeViewModel.isFetchingTasks;
      await homeViewModel.fetchTasks(
        onError: (e) {},
        onSuccess: (tasks) {},
      );

      expect(isFetchingTasksBefore, true);
    });

    test('should handle successful task fetching', () async {
      final mockTasks = [
        Task(id: 1, title: 'Test Task', completed: false),
      ];
      when(() => mockTaskService.fetchTasks()).thenAnswer(
        (_) async => mockTasks,
      );

      bool onSuccessCalled = false;
      bool onErrorCalled = false;

      await homeViewModel.fetchTasks(
        onError: (e) {
          onErrorCalled = true;
        },
        onSuccess: (tasks) {
          onSuccessCalled = true;
        },
      );

      expect(onSuccessCalled, true);
      expect(onErrorCalled, false);
      expect(homeViewModel.tasks, mockTasks);
    });

    test('should handle failure when fetching tasks', () async {
      when(() => mockTaskService.fetchTasks()).thenThrow(
        Failure('Failed to fetch tasks'),
      );

      bool onSuccessCalled = false;
      bool onErrorCalled = false;

      await homeViewModel.fetchTasks(
        onError: (e) {
          onErrorCalled = true;
        },
        onSuccess: (tasks) {
          onSuccessCalled = true;
        },
      );

      expect(onSuccessCalled, false);
      expect(onErrorCalled, true);
    });

    test('should load cached tasks successfully', () async {
      final cachedTasks = [
        Task(id: 1, title: 'Cached Task', completed: true),
      ];
      when(() => mockTaskCacheService.retrieveCachedTasks())
          .thenAnswer((_) async => cachedTasks);

      final result = await homeViewModel.loadCachedTasks();

      expect(result, cachedTasks);
    });

    test('should handle error while loading cached tasks', () async {
      when(() => mockTaskCacheService.retrieveCachedTasks())
          .thenThrow(Exception('Error loading cache'));

      final result = await homeViewModel.loadCachedTasks();

      expect(result, []);
    });

    test('should cache tasks successfully', () async {
      final tasksToCache = [
        Task(id: 1, title: 'New Task', completed: false),
      ];
      when(() => mockTaskCacheService.cacheTask(tasksToCache))
          .thenAnswer((_) async {});

      await homeViewModel.cachedTasks(tasksToCache);

      verify(() => mockTaskCacheService.cacheTask(tasksToCache)).called(1);
    });

    test('should handle error while caching tasks', () async {
      final tasksToCache = [
        Task(id: 1, title: 'New Task', completed: false),
      ];
      when(() => mockTaskCacheService.cacheTask(tasksToCache))
          .thenThrow(Exception('Error caching tasks'));

      await homeViewModel.cachedTasks(tasksToCache);

      verify(() => mockTaskCacheService.cacheTask(tasksToCache)).called(1);
    });
  });
}

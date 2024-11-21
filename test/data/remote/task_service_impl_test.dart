import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:univa_task/app/core/client/http_client.dart';
import 'package:univa_task/data/model/task_model.dart';
import 'package:univa_task/app/core/endpoint/endpoints.dart';
import 'package:univa_task/data/remote/task_service_impl.dart';

class MockCustomHttpClient extends Mock implements CustomHttpClient {}

void main() {
  late TaskServiceImpl taskService;
  late MockCustomHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockCustomHttpClient();
    taskService = TaskServiceImpl(mockHttpClient);
  });

  group('TaskService Tests', () {
    test('should return list of tasks for successful fetch', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: Endpoints.tasksUrl),
        data: [
          {"id": 1, "title": "Task 1", "completed": false},
          {"id": 2, "title": "Task 2", "completed": true},
        ],
        statusCode: 200,
      );
      when(() => mockHttpClient.get(
            url: Endpoints.tasksUrl,
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => mockResponse);

      final result = await taskService.fetchTasks();

      expect(result, isA<List<Task>>());
      expect(result?.length, 2);
      expect(result?[0].title, 'Task 1');
      expect(result?[1].completed, true);
    });

    test('should throw error when fetch tasks fails', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: Endpoints.tasksUrl),
        error: 'Failed to fetch tasks',
        response: Response(
          requestOptions: RequestOptions(path: Endpoints.tasksUrl),
          data: {'message': 'Internal Server Error'},
          statusCode: 500,
        ),
      );
      when(() => mockHttpClient.get(
            url: Endpoints.tasksUrl,
            headers: any(named: 'headers'),
          )).thenThrow(dioException);

      expect(
        () async => await taskService.fetchTasks(),
        throwsA(isA<DioException>()),
      );
    });

    test('should return empty list when no tasks are returned', () async {
      final mockResponse = Response(
        requestOptions: RequestOptions(path: Endpoints.tasksUrl),
        data: [],
        statusCode: 200,
      );
      when(() => mockHttpClient.get(
            url: Endpoints.tasksUrl,
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => mockResponse);

      final result = await taskService.fetchTasks();

      expect(result, isA<List<Task>>());
      expect(result?.isEmpty, true);
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:univa_task/app/core/client/http_client.dart';
import 'package:univa_task/app/core/endpoint/endpoints.dart';
import 'package:univa_task/data/remote/auth_service_impl.dart';

class MockCustomHttpClient extends Mock implements CustomHttpClient {}

void main() {
  late AuthServiceImpl authService;
  late MockCustomHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockCustomHttpClient();
    authService = AuthServiceImpl(mockHttpClient);
  });

  group('AuthService Tests', () {
    test('should return response for successful login', () async {
      final response = Response(
        requestOptions: RequestOptions(path: Endpoints.loginUrl),
        data: {'message': 'Login successful'},
        statusCode: 200,
      );
      when(() => mockHttpClient.post(
            url: Endpoints.loginUrl,
            data: any(named: 'data'),
            headers: any(named: 'headers'),
          )).thenAnswer((_) async => response);

      final result = await authService.login(
        email: 'test@example.com',
        password: 'password123',
      );

      expect(result, isA<Response>());
      expect(result?.statusCode, 200);
      expect(result?.data['message'], 'Login successful');
    });

    test('should throw an error for failed login due to DioException', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: Endpoints.loginUrl),
        error: 'Login failed',
        response: Response(
          requestOptions: RequestOptions(path: Endpoints.loginUrl),
          data: {'message': 'Invalid credentials'},
          statusCode: 400,
        ),
      );
      when(() => mockHttpClient.post(
            url: Endpoints.loginUrl,
            data: any(named: 'data'),
            headers: any(named: 'headers'),
          )).thenThrow(dioException);

      expect(
        () async => await authService.login(
          email: 'test@example.com',
          password: 'wrongpassword',
        ),
        throwsA(isA<DioException>()),
      );
    });

    test('should throw an error for failed login due to generic error', () async {
      when(() => mockHttpClient.post(
            url: Endpoints.loginUrl,
            data: any(named: 'data'),
            headers: any(named: 'headers'),
          )).thenThrow(Exception('Generic error'));

      expect(
        () async => await authService.login(
          email: 'test@example.com',
          password: 'password123',
        ),
        throwsA(isA<Exception>()),
      );
    });
  });
}

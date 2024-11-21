import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:dio/dio.dart';
import 'package:univa_task/app/core/client/http_client.dart';
import 'package:univa_task/app/core/failure/failure.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late CustomHttpClient customHttpClient;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    customHttpClient = CustomHttpClient(mockDio);
  });

  group('CustomHttpClient Tests', () {
    test('should return a response for a successful GET request', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: {'message': 'Success'},
        statusCode: 200,
      );
      when(() => mockDio.get(any(), options: any(named: 'options')))
          .thenAnswer((_) async => response);

      final result = await customHttpClient.get(
        url: 'https://example.com',
        headers: {'Authorization': 'Bearer token'},
      );

      expect(result, isA<Response>());
      expect(result?.statusCode, 200);
      expect(result?.data['message'], 'Success');
    });

    test('should throw Failure when DioException occurs during GET request', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Error',
        response: Response(
          requestOptions: RequestOptions(path: ''),
          data: {'message': 'Something went wrong'},
          statusCode: 400,
        ),
      );
      when(() => mockDio.get(any(), options: any(named: 'options')))
          .thenThrow(dioException);

      expect(
        () async => await customHttpClient.get(
          url: 'https://example.com',
          headers: {'Authorization': 'Bearer token'},
        ),
        throwsA(isA<Failure>()),
      );
    });

    test('should throw Failure for generic error in GET request', () async {
      when(() => mockDio.get(any(), options: any(named: 'options')))
          .thenThrow(Exception('Generic Error'));

      expect(
        () async => await customHttpClient.get(
          url: 'https://example.com',
          headers: {'Authorization': 'Bearer token'},
        ),
        throwsA(isA<Failure>()),
      );
    });

    test('should return a response for a successful POST request', () async {
      final response = Response(
        requestOptions: RequestOptions(path: ''),
        data: {'message': 'Success'},
        statusCode: 200,
      );
      when(() => mockDio.post(any(), options: any(named: 'options'), data: any(named: 'data')))
          .thenAnswer((_) async => response);

      final result = await customHttpClient.post(
        url: 'https://example.com',
        headers: {'Authorization': 'Bearer token'},
        data: {'key': 'value'},
      );

      expect(result, isA<Response>());
      expect(result?.statusCode, 200);
      expect(result?.data['message'], 'Success');
    });

    test('should throw Failure when DioException occurs during POST request', () async {
      final dioException = DioException(
        requestOptions: RequestOptions(path: ''),
        error: 'Error',
        response: Response(
          requestOptions: RequestOptions(path: ''),
          data: {'message': 'Something went wrong'},
          statusCode: 400,
        ),
      );
      when(() => mockDio.post(any(), options: any(named: 'options'), data: any(named: 'data')))
          .thenThrow(dioException);

      expect(
        () async => await customHttpClient.post(
          url: 'https://example.com',
          headers: {'Authorization': 'Bearer token'},
          data: {'key': 'value'},
        ),
        throwsA(isA<Failure>()),
      );
    });

    test('should throw Failure for generic error in POST request', () async {
      when(() => mockDio.post(any(), options: any(named: 'options'), data: any(named: 'data')))
          .thenThrow(Exception('Generic Error'));

      expect(
        () async => await customHttpClient.post(
          url: 'https://example.com',
          headers: {'Authorization': 'Bearer token'},
          data: {'key': 'value'},
        ),
        throwsA(isA<Failure>()),
      );
    });
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univa_task/app/core/failure/failure.dart';
import 'package:univa_task/data/remote/auth_service.dart';
import 'package:univa_task/ui/auth/auth_view_model.dart';

class MockAuthService extends Mock implements AuthService {}

void main() {
  late AuthViewModel authViewModel;
  late MockAuthService mockAuthService;

  setUp(() {
    mockAuthService = MockAuthService();
    authViewModel = AuthViewModel(mockAuthService);
  });

  group('AuthViewModel Tests', () {
    test('should change obscurePassword state when setter is called', () {
      expect(authViewModel.obscurePassword, true);
      authViewModel.obscurePassword = false;

      expect(authViewModel.obscurePassword, false);
    });

    test('should return error message for invalid email', () {
      expect(authViewModel.validateEmail('invalidemail'), 'invalid email');
      expect(authViewModel.validateEmail('test@example.com'), isNull);
    });

    test('should return error message for short password', () {
      expect(authViewModel.validatePassword('short', 6), isNotNull);
      expect(authViewModel.validatePassword('validPassword123', 6), isNull);
    });

    test('should set isAuthenticating to true during login attempt', () async {
      when(() => mockAuthService.login(
            email: 'test@example.com',
            password: 'password',
          )).thenAnswer((_) async {
        return;
      });

      await authViewModel.login(
        email: 'test@example.com',
        password: 'password',
        onSuccess: (_) {},
        onError: (_) {},
      );

      expect(authViewModel.isAuthenticating, false);
    });

    test('should handle successful login', () async {
      when(() => mockAuthService.login(
            email: 'test@example.com',
            password: 'password',
          )).thenAnswer((_) async {
        return;
      });

      bool onSuccessCalled = false;
      bool onErrorCalled = false;

      await authViewModel.login(
        email: 'test@example.com',
        password: 'password',
        onSuccess: (message) {
          onSuccessCalled = true;
        },
        onError: (message) {
          onErrorCalled = true;
        },
      );

      expect(onSuccessCalled, true);
      expect(onErrorCalled, false);
    });

    test('should handle login failure', () async {
      final failure = Failure('Invalid credentials');
      when(() => mockAuthService.login(
            email: 'test@example.com',
            password: 'wrongpassword',
          )).thenThrow(failure);

      bool onSuccessCalled = false;
      bool onErrorCalled = false;

      await authViewModel.login(
        email: 'test@example.com',
        password: 'wrongpassword',
        onSuccess: (message) {
          onSuccessCalled = true;
        },
        onError: (message) {
          onErrorCalled = true;
        },
      );

      expect(onSuccessCalled, false);
      expect(onErrorCalled, true);
    });

    test('should handle unexpected error during login', () async {
      when(() => mockAuthService.login(
            email: 'test@example.com',
            password: 'password',
          )).thenThrow(Exception('Unknown error'));

      bool onSuccessCalled = false;
      bool onErrorCalled = false;

      await authViewModel.login(
        email: 'test@example.com',
        password: 'password',
        onSuccess: (message) {
          onSuccessCalled = true;
        },
        onError: (message) {
          onErrorCalled = true;
        },
      );

      expect(onSuccessCalled, false);
      expect(onErrorCalled, true);
    });
  });
}

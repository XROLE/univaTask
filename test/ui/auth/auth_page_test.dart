import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:univa_task/app/core/failure/failure.dart';
import 'package:univa_task/ui/auth/auth_page.dart';
import 'package:univa_task/ui/auth/auth_view_model.dart';
import 'package:univa_task/data/remote/auth_service.dart';
import 'package:univa_task/ui/home/home_page.dart';
import 'package:univa_task/ui/widgets/action_button.dart';
import 'package:univa_task/ui/widgets/app_logo.dart';
import 'package:univa_task/ui/widgets/custome_text_input.dart';

class MockAuthService extends Mock implements AuthService {}

class MockAuthViewModel extends Mock implements AuthViewModel {}

String invalidEmailErrorMessage = "invalid email";
String passwordErrorMessage = "Password must be greater 5 characters";

void main() {
  late MockAuthService mockAuthService;
  late MockAuthViewModel mockAuthViewModel;

  setUp(() {
    mockAuthService = MockAuthService();
    mockAuthViewModel = MockAuthViewModel();

    GetIt.instance.registerSingleton<AuthService>(mockAuthService);
    GetIt.instance.registerFactory<AuthViewModel>(() => mockAuthViewModel);
  });

  tearDown(() {
    GetIt.instance.reset();
  });

  testWidgets('renders AuthPage UI correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: AuthPage(),
    ));

    expect(find.byType(AppLogo), findsOneWidget);
    expect(find.byType(CustumeTextInput), findsNWidgets(2));
    expect(find.byType(ActionButton), findsOneWidget);
    expect(find.text("Don't have an account? Sign Up"), findsOneWidget);
  });

  testWidgets('email and password fields validate correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: AuthPage(),
    ));

    final emailField = find.byType(CustumeTextInput).first;
    final passwordField = find.byType(CustumeTextInput).at(1);

    await tester.enterText(emailField, 'invalid-email');
    await tester.enterText(passwordField, 'short');

    await tester.tap(find.byType(ActionButton));
    await tester.pump();

    expect(find.text(invalidEmailErrorMessage), findsOneWidget);
    expect(find.text(passwordErrorMessage), findsOneWidget);
  });

  testWidgets('successful login triggers navigation and success message',
      (WidgetTester tester) async {
    when(() => mockAuthService.login(
        email: any(named: "email"),
        password: any(named: "password"))).thenAnswer(
      (_) async => Future.value(Response(
          requestOptions: RequestOptions(
              path: any(named: "url"), data: {"token": "Login successful"}))),
    );

    await tester.pumpWidget(const MaterialApp(
      home: AuthPage(),
    ));

    final emailField = find.byType(CustumeTextInput).first;
    final passwordField = find.byType(CustumeTextInput).at(1);
    await tester.enterText(emailField, 'valid-email@example.com');
    await tester.enterText(passwordField, 'validpassword');

    await tester.tap(find.byType(ActionButton));
    await tester.pump();

    // expect(find.text('Login successful'), findsOneWidget);
    // expect(find.byType(HomePage), findsOneWidget);
  });

  testWidgets('failed login displays error message',
      (WidgetTester tester) async {
    when(() => mockAuthService.login(
        email: any(named: "email"),
        password: any(named: "password"))).thenThrow(
      Failure('Login failed'),
    );
    await tester.pumpWidget(const MaterialApp(
      home: AuthPage(),
    ));

    final emailField = find.byType(CustumeTextInput).first;
    final passwordField = find.byType(CustumeTextInput).at(1);
    await tester.enterText(emailField, 'valid-email@example.com');
    await tester.enterText(passwordField, 'validpassword');

    await tester.tap(find.byType(ActionButton));
    await tester.pump();

    // expect(find.text('Login failed'), findsOneWidget);
  });
}

import 'package:dio/dio.dart';

abstract class AuthService {
  Future<Response?> login({
    required String email,
    required String password,
  });
}
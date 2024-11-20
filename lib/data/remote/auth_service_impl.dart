import 'package:dio/dio.dart';
import 'package:univa_task/app/core/client/http_client.dart';
import 'package:univa_task/app/core/endpoint/endpoints.dart';
import 'package:univa_task/data/remote/auth_service.dart';

class AuthServiceImpl implements AuthService {
  final CustomHttpClient httpClient;
  AuthServiceImpl(this.httpClient);

  @override
  Future<Response?> login({
    required String email,
    required String password,
  }) async {
    Map<String, String> data = {
      "email": email,
      "password": password,
    };
    return await httpClient
        .post(url: Endpoints.loginUrl, data: data, headers: {});
  }
}

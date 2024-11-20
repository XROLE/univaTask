import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:univa_task/app/core/failure/failure.dart';
import 'package:univa_task/data/remote/auth_service.dart';
import 'package:univa_task/ui/base/base_view_model.dart';
import 'package:univa_task/utils/constants/error_text.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService authService;
  AuthViewModel(this.authService);

  bool _isAuthenticating = false;
  bool get isAuthenticating => _isAuthenticating;
  set isAuthenticating(bool val) {
    _isAuthenticating = val;
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
    required Function(String e) onSuccess,
    required Function(String e) onError,
  }) async {
    try {
      isAuthenticating = true;
      Response? res = await authService.login(email: email, password: password);
      bool successStatus = res?.data["success"] ?? false;
      String message = res?.data["message"] ?? "";

      isAuthenticating = false;
      if (successStatus == false) {
        throw Failure(message);
      }
      onSuccess(message);
    } on Failure catch (e) {
      isAuthenticating = false;
      onError(e.errorMessage);
      debugPrint("FAilure ==============> $e");
    } catch (e) {
      isAuthenticating = false;
      onError(ErrorText.generic);
      debugPrint("Error ==============> $e");
    }
  }
}

import 'package:flutter/material.dart';
import 'package:univa_task/app/core/failure/failure.dart';
import 'package:univa_task/data/remote/auth_service.dart';
import 'package:univa_task/ui/base/base_view_model.dart';
import 'package:univa_task/utils/app_validator.dart';
import 'package:univa_task/utils/constants/error_text.dart';

class AuthViewModel extends BaseViewModel {
  final AuthService authService;
  AuthViewModel(this.authService);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;
  set obscurePassword(bool val) {
    _obscurePassword = val;
    notifyListeners();
  }

  bool _isAuthenticating = false;
  bool get isAuthenticating => _isAuthenticating;
  set isAuthenticating(bool val) {
    _isAuthenticating = val;
    notifyListeners();
  }

  String? validateEmail(String? email) {
    String error = "invalid email";
    if (email == null) return error;

    return AppValidator().isValidEmail(email) ? null : error;
  }

  String? validatePassword(String? password, int len) {
    return AppValidator()
        .validateLength(title: "Password", val: password, len: len);
  }

  Future<void> login({
    required String email,
    required String password,
    required Function(String e) onSuccess,
    required Function(String e) onError,
  }) async {
    try {
      isAuthenticating = true;
     await authService.login(email: email, password: password);

      String message = "login successfully";
      isAuthenticating = false;

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

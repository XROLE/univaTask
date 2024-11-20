class AppValidator {
  String? validateLength(
      {required String title, required String? val, required int len}) {
    String error = "$title must be greater ${len - 1} characters";
    if (val == null) return error;

    return val.length < len ? error : null;
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}

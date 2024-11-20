class Failure {
  int? statusCode;
  String errorMessage;

  Failure(this.errorMessage, {this.statusCode});

  @override
  String toString() {
    return 'Failure{statusCode: $statusCode, errorMessage: $errorMessage}';
  }
}
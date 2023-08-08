
class HttpExceptions implements Exception {
  final String errorMessage;

  HttpExceptions(this.errorMessage);
  @override
  String toString() {

    return errorMessage;
  }
}
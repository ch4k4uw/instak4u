class AppCredentialException implements Exception {
  final String message;
  const AppCredentialException([this.message = ""]);

  @override
  String toString() => "$runtimeType: $message";
}
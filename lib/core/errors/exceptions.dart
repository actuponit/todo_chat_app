class MyFirebaseAuthException implements Exception {
  final String message;

  MyFirebaseAuthException(this.message);

  @override
  String toString() => 'MyFirebaseAuthException: $message';
}

class MyFirebaseDBException implements Exception {
  final String message;

  MyFirebaseDBException(this.message);

  @override
  String toString() => 'MyFirebaseDatabaseException: $message';
}
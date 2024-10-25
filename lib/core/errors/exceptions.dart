class MyFirebaseException implements Exception {
  final String message;

  MyFirebaseException(this.message);

  @override
  String toString() => 'MyFirebaseException: $message';
}

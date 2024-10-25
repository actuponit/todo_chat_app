import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object?> get props => [message];
}

class FirebaseFailure extends Failure {
  const FirebaseFailure(super.message);
}

class UnexpectedFailure extends Failure {
  const UnexpectedFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class NoConnection extends Failure {
  const NoConnection(super.message);
}

class InvalidInputFailure extends Failure {
  const InvalidInputFailure(super.message);
}
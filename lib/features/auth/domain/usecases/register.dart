import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class Register extends UseCase<User, RegisterParams> {
  final UserRepository repository;

  Register(this.repository);

  @override
  Future<Either<Failure, User>> call(RegisterParams params) async {
    return await repository.register(params.email, params.password);
  }
}

class RegisterParams extends Equatable {
  final String email;
  final String password;

  const RegisterParams({required this.email, required this.password});
  
  @override
  List<Object?> get props => [email, password];
}
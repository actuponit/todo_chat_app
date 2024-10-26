import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_repository.dart';

class Logout extends UseCase {
  final UserRepository repository;
  Logout(this.repository);

  @override
  Future<Either<Failure, void>> call(params) {
    return repository.logout();
  }
  
}
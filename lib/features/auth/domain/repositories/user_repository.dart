import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, User>> getUser();
  Future<Either<Failure, User>> login(String email, String password);
  Future<Either<Failure, User>> register(User user);
  Future<Either<Failure, void>> logout();
}
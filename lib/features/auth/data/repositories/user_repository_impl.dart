import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failure.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/auth_datasource.dart';
import '../models/user_model.dart';

class UserRepositoryImpl extends UserRepository{
  final AuthDatasource datasource;

  UserRepositoryImpl({required this.datasource});
  
  @override
  Future<Either<Failure, User>> getUser() async {
    try {
      return Right(await datasource.getUser());
    } on MyFirebaseException catch (e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(UnexpectedFailure('Error while getting user: $e'));
    }
  }

  @override
  Future<Either<Failure, User>> login(String email, String password) async {
    try {
      return Right(await datasource.login(email, password));
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return const Left(FirebaseFailure('No user found for that email.'));
      } else if (e.code == 'wrong-password') {
        return const Left(FirebaseFailure('Wrong password provided for that user.'));
      }
      print(e);
      return Left(FirebaseFailure('Firebase Error: Login Error occured: ${e.message}'));
    } on MyFirebaseException catch(e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(UnexpectedFailure('Error while logging in: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      return Right(await datasource.logout());
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(FirebaseFailure('Firebase Logout Error: ${e.message}'));
    } catch (e) {
      print(e);
      return const Left(UnexpectedFailure('Unepected Error'));
    }
  }

  @override
  Future<Either<Failure, User>> register(User user) async {
    try {
      return Right(await datasource.register(UserModel.fromEntity(user)));
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return const Left(FirebaseFailure('Firebase Error: Weak password pls change your password.'));
      } else if (e.code == 'email-already-in-use') {
        return const Left(FirebaseFailure('Firebase Error: Email already in use.'));
      }
      print(e);
      return Left(FirebaseFailure('Firebase Error: ${e.message}'));
    } on MyFirebaseException catch(e) {
      return Left(FirebaseFailure(e.toString()));
    } catch (e) {
      return Left(UnexpectedFailure('Error while logging in: $e'));
    }
  }

}
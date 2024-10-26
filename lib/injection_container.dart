import 'package:get_it/get_it.dart';

import 'features/auth/data/datasources/auth_datasource.dart';
import 'features/auth/data/datasources/auth_datasource_impl.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/domain/usecases/get_user.dart';
import 'features/auth/domain/usecases/login.dart';
import 'features/auth/domain/usecases/logout.dart';
import 'features/auth/domain/usecases/register.dart';
import 'features/auth/presentation/blocs/bloc/auth_bloc.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Feature: auth

  // bloc
  locator.registerFactory(() => AuthBloc(
    getUserUsecase: locator(),
    loginUsecase: locator(),
    registerUsecase: locator(),
    logoutUsecase: locator(),
  ));

  // usecases
  locator.registerLazySingleton(() => GetUser(locator()));
  locator.registerLazySingleton(() => Login(locator()));
  locator.registerLazySingleton(() => Register(locator()));
  locator.registerLazySingleton(() => Logout(locator()));

  // repositories
  locator.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(datasource: locator()));

  // datasource
  locator.registerLazySingleton<AuthDatasource>(() => AuthDatasourceImpl());
}
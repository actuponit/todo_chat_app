import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_user.dart';
import '../../../domain/usecases/login.dart';
import '../../../domain/usecases/logout.dart';
import '../../../domain/usecases/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GetUser getUserUsecase;
  final Login loginUsecase;
  final Register registerUsecase;
  final Logout logoutUsecase;

  AuthBloc({
    required this.getUserUsecase, 
    required this.loginUsecase,
    required this.registerUsecase,
    required this.logoutUsecase,
    }) : super(AuthInitial()) {
    on<AuthStarted>((event, emit) async {
      emit(AuthLoading());
      final res = await getUserUsecase(NoParams());
      res.fold(
        (failure) => emit(AuthUnauthenticated()),
        (user) => emit(AuthAuthenticated(user)),
      );
    });

    on<AuthLoginStarted>((event, emit) async {
      emit(AuthLoading());
      final res = await loginUsecase(LoginParams(email: event.email, password: event.password));
      res.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthAuthenticated(user)),
      );
    });

    on<AuthRegisterStarted>((event, emit) async {
      emit(AuthLoading());
      final user = User(id: '', email: event.email, name: event.name, password: event.password);
      final res = await registerUsecase(RegisterParams(user: user));
      res.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthAuthenticated(user)),
      );
    });

    on<AuthLogoutStarted>((event, emit) async {
      emit(AuthLoading());
      final res = await logoutUsecase(NoParams());
      res.fold(
        (failure) => emit(AuthError(failure.message)),
        (_) => emit(AuthUnauthenticated()),
      );
    });
  }
}

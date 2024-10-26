part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthStarted extends AuthEvent {}

final class AuthLoginStarted extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginStarted(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

final class AuthRegisterStarted extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const AuthRegisterStarted(this.email, this.password, this.name);

  @override
  List<Object> get props => [email, password, name];
}

final class AuthLogoutStarted extends AuthEvent {}

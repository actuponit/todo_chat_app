import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String email;
  final String name;
  final String password;
  final bool online;
  final DateTime? lastseen;

  const User({
    required this.id,
    required this.email,
    required this.name,
    this.password = '',
    this.online = true,
    this.lastseen,
  });

  @override
  List<Object?> get props => [id, email, name];
}
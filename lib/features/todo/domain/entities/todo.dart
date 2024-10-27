import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String? id;
  final String name;
  final DateTime createdAt;
  final bool status;

  Todo({this.id, required this.name, this.status = false, createdAt}):createdAt=createdAt ?? DateTime.now();
  
  @override
  List<Object?> get props => [name, createdAt, status];
}
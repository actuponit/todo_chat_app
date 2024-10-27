import 'package:equatable/equatable.dart';

import '../../../auth/domain/entities/user.dart';
import 'todo.dart';

class TodoList extends Equatable {
  final String? title;
  final String createdBy;
  final List<String>? editableBy;
  final List<Todo> todos;
  final List<User>? users;
  final int? createdAt;
  final DateTime? updatedAt;
  final String? id;

  const TodoList({
    this.id,
    this.title,
    required this.createdBy,
    this.editableBy,
    this.todos = const [],
    this.createdAt,
    this.updatedAt,
    this.users,
  });
  
  @override
  List<Object?> get props => [title, createdBy, editableBy, todos];
}
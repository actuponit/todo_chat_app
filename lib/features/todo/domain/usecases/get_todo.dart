import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../entities/todo_list.dart';
import '../repositories/todo_repository.dart';

class GetTodoParams extends Equatable {
  final String id;

  const GetTodoParams({required this.id});
  
  @override
  List<Object?> get props => [id];
}

class GetTodo {
  final TodoRepository repository;
  const GetTodo(this.repository);

  Future<Stream<Either<Failure, TodoList>>> call(GetTodoParams param) async {
    return await repository.getTodos(param.id);
  }
}
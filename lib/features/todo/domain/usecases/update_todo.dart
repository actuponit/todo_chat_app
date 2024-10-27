import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoParams extends Equatable {
  final Todo todo;
  final String id;
  final String todoListId;

  const UpdateTodoParams({required this.todo, required this.id, required this.todoListId});

  @override
  List<Object?> get props => [todo, id, todoListId];
}

class UpdateTodo extends UseCase<Todo, UpdateTodoParams> {
  final TodoRepository repository;

  UpdateTodo(this.repository);

  @override
  Future<Either<Failure, Todo>> call(UpdateTodoParams params) async {
    return await repository.updateTodo(params.todoListId, params.id,  params.todo);
  }
}
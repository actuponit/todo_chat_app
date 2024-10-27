import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class AddTodoParams extends Equatable {
  final Todo todo;
  final String id;

  const AddTodoParams({required this.todo, required this.id});

  @override
  List<Object?> get props => [todo, id];
}

class AddTodo extends UseCase<Todo, AddTodoParams> {
  final TodoRepository repository;

  AddTodo(this.repository);

  @override
  Future<Either<Failure, Todo>> call(AddTodoParams params) async {
    return await repository.addTodo(params.id, params.todo);
  }
}
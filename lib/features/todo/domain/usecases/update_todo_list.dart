import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo_list.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoListParams extends Equatable {
  final TodoList todoList;
  final String id;

  const UpdateTodoListParams({required this.todoList, required this.id});

  @override
  List<Object?> get props => [todoList, id];
}

class UpdateTodoList extends UseCase<TodoList, UpdateTodoListParams> {
  final TodoRepository repository;

  UpdateTodoList(this.repository);

  @override
  Future<Either<Failure, TodoList>> call(UpdateTodoListParams params) async {
    return await repository.updateTodoList(params.id, params.todoList);
  }
}
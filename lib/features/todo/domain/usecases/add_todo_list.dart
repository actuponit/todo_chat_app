import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo_list.dart';
import '../repositories/todo_repository.dart';

class AddTodoListParams extends Equatable {
  final TodoList todoList;

  const AddTodoListParams({required this.todoList});

  @override
  List<Object?> get props => [todoList];
}

class AddTodoList extends UseCase<TodoList, AddTodoListParams> {
  final TodoRepository repository;

  AddTodoList(this.repository);

  @override
  Future<Either<Failure, TodoList>> call(AddTodoListParams params) async {
    return await repository.addTodoList(params.todoList);
  }
}
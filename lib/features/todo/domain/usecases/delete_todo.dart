import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/todo_repository.dart';

class DeleteTodoParams extends Equatable {
  final String id;
  final String todoListId;

  const DeleteTodoParams({required this.id, required this.todoListId});
  
  @override
  List<Object?> get props => [id, todoListId];
}

class DeleteTodo extends UseCase<void, DeleteTodoParams>{
  final TodoRepository repository;

  DeleteTodo(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTodoParams params) async {
    return await repository.deleteTodo(params.todoListId, params.id);
  }

}
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/todo_repository.dart';

class DeleteTodoListParams extends Equatable {
  final String id;

  const DeleteTodoListParams({required this.id});
  
  @override
  List<Object?> get props => [id];
}

class DeleteTodoList extends UseCase<void, DeleteTodoListParams>{
  final TodoRepository repository;

  DeleteTodoList(this.repository);

  @override
  Future<Either<Failure, void>> call(DeleteTodoListParams params) async {
    return await repository.deleteTodoList(params.id);
  }

}
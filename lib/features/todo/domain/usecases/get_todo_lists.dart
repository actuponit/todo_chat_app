import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/todo_list.dart';
import '../repositories/todo_repository.dart';

class GetTodoLists {
  final TodoRepository repository;

  GetTodoLists(this.repository);

  Future<Stream<Either<Failure, List<TodoList>>>> call(NoParams params) async {
    return await repository.getTodoLists();
  }
}
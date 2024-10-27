import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_list.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_datasource.dart';
import '../models/todo_list_model.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl extends TodoRepository {
  final TodoDatasource datasource;

  TodoRepositoryImpl(this.datasource);
  
  @override
  Future<Either<Failure, Todo>> addTodo(String id, Todo todo) async {
    try {
      return Right(await datasource.addTodo(id, TodoModel.fromEntity(todo)));
    } catch (e) {
      return const Left(UnexpectedFailure('An unexpected error ocurred'));
    }
  }

  @override
  Future<Either<Failure, TodoList>> addTodoList(TodoList todoList) async {
    try {
      return Right(await datasource.addTodoList(TodoListModel.fromEntity(todoList)));
    } catch (e) {
      return const Left(UnexpectedFailure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodo(String todoListId, String id) async {
    try {
      return Right(await datasource.deleteTodo(todoListId, id));
    } catch (e) {
      return Left(UnexpectedFailure('An Expected error occured: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTodoList(String id) async {
    try {
      return Right(await datasource.deleteTodoList(id));
    } catch (e) {
      return Left(UnexpectedFailure('An Expected error occured: $e'));
    }
  }

  @override
  Future<Stream<Either<Failure, List<TodoList>>>> getTodoLists() async {
    try {
      final result = datasource.getTodoLists();
      return result.map((event) {
        return Right(event);
      });
    } catch (e) {
      print(e);
      return Stream.value(const Left(UnexpectedFailure('An unexpected error occurred')));
    }
  }

  @override
  Future<Stream<Either<Failure, TodoList>>> getTodos(String id) async {
    try {
      final result = datasource.getTodos(id);
      return result.map((event) {
        return Right(event);
      });
    } catch (e) {
      print(e);
      return Stream.value(const Left(UnexpectedFailure('An unexpected error occurred')));
    }
  }

  @override
  Future<Either<Failure, Todo>> updateTodo(String todoListId, String id, Todo todo) async {
    try {
      await datasource.updateTodo(todoListId, id, TodoModel.fromEntity(todo));
      return Right(todo);
    } catch (e) {
      return Left(UnexpectedFailure('Error: $e'));
    }
  }

  @override
  Future<Either<Failure, TodoList>> updateTodoList(String id, TodoList todoList) async {
    try {
      await datasource.updateTodoList(id, TodoListModel.fromEntity(todoList));
      return Right(todoList);
    } catch (e) {
      return Left(UnexpectedFailure('Error: $e'));
    }
  }

}
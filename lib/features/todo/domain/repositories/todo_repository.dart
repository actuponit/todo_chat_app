import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/todo.dart';
import '../entities/todo_list.dart';

abstract class TodoRepository {
  Future<Stream<Either<Failure, List<TodoList>>>> getTodoLists();
  Future<Stream<Either<Failure, TodoList>>> getTodos(String id);
  
  Future<Either<Failure, TodoList>> addTodoList(TodoList todoList);
  Future<Either<Failure, Todo>> addTodo(String id, Todo todo);

  Future<Either<Failure, TodoList>> updateTodoList(String id, TodoList todoList);
  Future<Either<Failure, Todo>> updateTodo(String todoListId, String id, Todo todo);

  Future<Either<Failure, void>> deleteTodoList(String id);
  Future<Either<Failure, void>> deleteTodo(String todoListId, String id);
}
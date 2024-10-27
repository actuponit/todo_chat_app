import '../models/todo_list_model.dart';
import '../models/todo_model.dart';

abstract class TodoDatasource {
  Stream<List<TodoListModel>> getTodoLists();
  Stream<TodoListModel> getTodos(String id);
  
  Future<TodoListModel> addTodoList(TodoListModel todoList);
  Future<TodoModel> addTodo(String id, TodoModel todo);

  Future<void> updateTodoList(String id, TodoListModel todoList);
  Future<void> updateTodo(String todoListId, String id, TodoModel todo);

  Future<void> deleteTodoList(String id);
  Future<void> deleteTodo(String todoListId, String id);
}
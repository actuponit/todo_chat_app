import 'package:firebase_database/firebase_database.dart';

import '../models/todo_list_model.dart';
import '../models/todo_model.dart';
import 'todo_datasource.dart';

class TodoDatasourceImp extends TodoDatasource {
  final DatabaseReference _dbref;

  TodoDatasourceImp({DatabaseReference? dbref}) : _dbref = dbref ?? FirebaseDatabase.instance.ref('todos');

  @override
  Future<TodoModel> addTodo(String id, TodoModel todo) async {
    await _dbref.child(id).push().set(todo.toJson());
    return todo;
  }

  @override
  Future<TodoListModel> addTodoList(TodoListModel todoList) async {
    await _dbref.push().set(todoList.toJson());
    return todoList;
  }

  @override
  Future<void> deleteTodo(String todoListId, String id) async {
    await _dbref.child(todoListId).child(id).remove();
  }

  @override
  Future<void> deleteTodoList(String id) async {
    await _dbref.child(id).remove();
  }

  @override
  Stream<List<TodoListModel>> getTodoLists() {
    return _dbref.onValue.map((event) {
      final data = event.snapshot.value as Map;
      final todoLists = data.entries.map((e) => TodoListModel.fromJson(Map<String, dynamic>.from(e.value), e.key)).toList();
      return todoLists;
    });
  }

  @override
  Stream<TodoListModel> getTodos(String id) {
    return _dbref.child(id).onValue.map((event) {
      final data = event.snapshot.value as Map;
      final todoList = TodoListModel.fromJson(Map<String, dynamic>.from(data), id);
      return todoList;
    });
  }

  @override
  Future<void> updateTodo(String todoListId, String id, TodoModel todo) async {
    await _dbref.child(todoListId).child(id).update(todo.toJson());
  }

  @override
  Future<void> updateTodoList(String id, TodoListModel todoList) async {
    await _dbref.child(id).update(todoList.toJson());
  }

}
import 'package:firebase_database/firebase_database.dart';

import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_list.dart';
import 'todo_model.dart';

class TodoListModel extends TodoList {
  const TodoListModel({
    required super.createdBy,
    super.title,
    super.editableBy,
    super.todos = const [],
    super.users,
    super.createdAt,
    super.updatedAt,
    super.id,
  });

  static List<Todo> fromTodoJson(Map<String, dynamic> json) {
    final todos = <Todo>[];
    json.forEach((key, value) {
      todos.add(TodoModel.fromJson(value as Map<String, dynamic>, key));
    });
    return todos;
  }

  static List<String> fromUsers(Map<String, dynamic> ediatableBy) {
    return ediatableBy.keys.toList();
  }

  factory TodoListModel.fromJson(Map<String, dynamic> json, String id) {
    return TodoListModel(
      createdBy: json['createdBy'] ?? '',
      title: json['title'],
      editableBy: fromUsers(Map<String, dynamic>.from(json['editableBy'])),
      todos: json['todos'] == null ? [] : fromTodoJson(Map<String, dynamic>.from(json['todos'])),
      createdAt: json['createdAt'] as int,
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updatedAt'] as int),
      id: id,
    );
  }

  factory TodoListModel.fromEntity(TodoList entity) {
    return TodoListModel(
      createdBy: entity.createdBy,
      title: entity.title,
      editableBy: entity.editableBy,
      todos: entity.todos,
      users: entity.users,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      id: entity.id,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{
      'createdBy': createdBy,
      'updatedAt': ServerValue.timestamp,
    };

    if (title != null) {
      map['title'] = title;
    }

    if (editableBy != null) {
      final editableByMp = <String, bool>{
        createdBy: true
      };
      editableBy?.forEach((e) { editableByMp[e] = true; });
      map['editableBy'] = editableByMp;
    }

    if (createdAt != null) {
      map['createdAt'] = createdAt;
    }
    return map;
  }
}
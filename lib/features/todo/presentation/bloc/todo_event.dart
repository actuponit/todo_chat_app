part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class TodoListAddStarted extends TodoEvent {
  final String title;
  final List<String> editableBy;
  final String createdBy;

  const TodoListAddStarted({required this.title, required this.editableBy, required this.createdBy});

  @override
  List<Object> get props => [title, editableBy];
}

final class GetTodoListsStarted extends TodoEvent {}

final class GetTodoStarted extends TodoEvent {
  final String id;

  const GetTodoStarted({required this.id});

  @override
  List<Object> get props => [id];
}

final class TodoListUpdateStarted extends TodoEvent {}

final class TodoListDeleteStarted extends TodoEvent {}

final class TodoUpdateStarted extends TodoEvent {}

final class TodoDeleteStarted extends TodoEvent {}

final class TodoAddStarted extends TodoEvent {
  final String name;
  final String id;

  const TodoAddStarted({required this.name, required this.id});

  @override
  List<Object> get props => [name, id];
}
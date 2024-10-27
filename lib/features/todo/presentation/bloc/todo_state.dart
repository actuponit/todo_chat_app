part of 'todo_bloc.dart';

sealed class TodoState extends Equatable {
  const TodoState();
  
  @override
  List<Object> get props => [];
}

final class TodoInitial extends TodoState {}

final class TodoLoading extends TodoState {}

final class TodoLoaded extends TodoState {
  final List<TodoList> todoLists;

  const TodoLoaded(this.todoLists);

  @override
  List<Object> get props => [todoLists];
}

final class TodoError extends TodoState {
  final String message;

  const TodoError(this.message);

  @override
  List<Object> get props => [message];
}

final class TodoAdded extends TodoState {}

final class TodoUpdated extends TodoState {}

final class TodoDeleted extends TodoState {}

final class TodoListLoaded extends TodoState {
  final TodoList todo;

  const TodoListLoaded(this.todo);

  @override
  List<Object> get props => [todo];
}

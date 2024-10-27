import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/todo.dart';
import '../../domain/entities/todo_list.dart';
import '../../domain/usecases/add_todo.dart';
import '../../domain/usecases/add_todo_list.dart';
import '../../domain/usecases/delete_todo.dart';
import '../../domain/usecases/delete_todo_list.dart';
import '../../domain/usecases/get_todo.dart';
import '../../domain/usecases/get_todo_lists.dart';
import '../../domain/usecases/update_todo.dart';
import '../../domain/usecases/update_todo_list.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final AddTodoList addTodoList;
  final GetTodoLists getTodoLists;
  final GetTodo getTodo;
  final AddTodo addTodo;
  final DeleteTodo deleteTodo;
  final UpdateTodo updateTodo;
  final DeleteTodoList deleteTodoList;
  final UpdateTodoList updateTodoList;

  TodoBloc({
    required this.addTodoList,
    required this.getTodoLists,
    required this.getTodo,
    required this.addTodo,
    required this.deleteTodo, 
    required this.updateTodo, 
    required this.deleteTodoList, 
    required this.updateTodoList,
  }) : super(TodoInitial()) {
    on<TodoListAddStarted>((event, emit) async {
      emit(TodoLoading());
      final todoList = TodoList(createdBy: event.createdBy, title: event.title, editableBy: event.editableBy, createdAt: DateTime.now().millisecondsSinceEpoch);
      final result = await addTodoList(AddTodoListParams(todoList:todoList));
      result.fold(
        (l) => emit(TodoError(l.message)),
        (r) => emit(TodoAdded()),
      );
    });

    on<TodoAddStarted>((event, emit) async {
      emit(TodoLoading());
      final todo = Todo(name: event.name, createdAt: DateTime.now().millisecondsSinceEpoch);
      final result = await addTodo(AddTodoParams(todo:todo, id: event.id));
      result.fold(
        (l) => emit(TodoError(l.message)),
        (r) => emit(TodoAdded()),
      );
    });

    on<GetTodoListsStarted>((event, emit) async {
      emit(TodoLoading());
      final todoStream = await getTodoLists(NoParams());
      await emit.forEach(todoStream, onData: (data) {
        return data.fold<TodoState>(
          (l) => TodoError(l.message),
          (r) => TodoLoaded(r),
        );
      });
    });

    on<GetTodoStarted>((event, emit) async {
      emit(TodoLoading());
      final todoStream = await getTodo(GetTodoParams(id: event.id));
      await emit.forEach(todoStream, onData: (data) {
        return data.fold<TodoState>(
          (l) => TodoError(l.message),
          (r) => TodoListLoaded(r),
        );
      });
    });
  }
}

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/core.dart';
import 'package:todo/models/models.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this.apiService) : super(const TodoState());

  final ApiService apiService;

  Future<void> getTodos() async {
    emit(state.copyWith(status: FetchStatus.loading));
    final (todos, errorText) = await apiService.getTypeList<Todo>(
      'http://localhost:8080/todos',
      fromJson: Todo.fromJson,
    );
    if (todos != null) return emit(state.copyWith(todos: todos, status: FetchStatus.success));
    emit(state.copyWith(errorText: errorText, status: FetchStatus.error));
  }

  Future<void> addTodo(Todo todo) async {
    final (success, errorText) = await apiService.post(
      'http://localhost:8080/todos',
      todo.toJson(),
    );

    if (success != null) return emit(state.copyWith(status: FetchStatus.success));
    emit(state.copyWith(errorText: errorText, status: FetchStatus.error));
  }

  Future<void> putTodo(Todo oldTodo) async {
    emit(state.copyWith(status: FetchStatus.loading));
    final newTodo = Todo(
      title: oldTodo.title,
      description: oldTodo.description,
      isCompleted: !oldTodo.isCompleted,
    );
    final (success, errorText) = await apiService.put(
      'http://localhost:8080/todos/${oldTodo.id}',
      newTodo.toJson(),
    );
    if (success == null) return emit(state.copyWith(errorText: errorText, status: FetchStatus.error));
    emit(state.copyWith(todos: state.changeTodos(oldTodo, newTodo), status: FetchStatus.success));
  }

  Future<void> delete(Todo todo) async {
    emit(state.copyWith(status: FetchStatus.loading));

    final (success, errorText) = await apiService.delete(
      'http://localhost:8080/todos/${todo.id}',
    );
    if (success == null) return emit(state.copyWith(errorText: errorText, status: FetchStatus.error));
    emit(state.copyWith(todos: state.deleteTodo(todo), status: FetchStatus.success));
  }
}

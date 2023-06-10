import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/core/core.dart';
import 'package:todo/models/models.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit(this.apiService) : super(const TodoState());

  final ApiService apiService;

  Future<void> getTodos() async {
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
}

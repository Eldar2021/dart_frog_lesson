// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'todo_cubit.dart';

class TodoState extends Equatable {
  const TodoState({
    this.status = FetchStatus.initial,
    this.todos,
    this.errorText,
  });
  final FetchStatus status;
  final List<Todo>? todos;
  final String? errorText;

  @override
  List<Object?> get props => [status, todos, errorText];

  TodoState copyWith({
    FetchStatus? status,
    List<Todo>? todos,
    String? errorText,
  }) {
    return TodoState(
      status: status ?? this.status,
      todos: todos ?? this.todos,
      errorText: errorText ?? this.errorText,
    );
  }

  List<Todo>? changeTodos(Todo oldTodo, Todo newTodo) {
    final index = todos?.indexOf(oldTodo);
    if (index != -1) todos?[index ?? 0] = newTodo;
    return todos;
  }

  List<Todo>? deleteTodo(Todo todo) {
    todos?.remove(todo);
    return todos;
  }
}

enum FetchStatus { initial, loading, success, error }

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
}

enum FetchStatus { initial, loading, success, error }

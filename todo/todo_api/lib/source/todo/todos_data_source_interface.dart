import 'package:todo_api/models/models.dart';

abstract class TodosDataSourceInterface {
  Future<Todo> createTodo(Todo todo);

  Future<List<Todo>> getTodos();

  Future<Todo?> getTodo(String id);

  Future<Todo> updateTodo(String id, Todo todo);

  Future<void> deleteTodo(String id);

  Future<void> deleteTodos();
}

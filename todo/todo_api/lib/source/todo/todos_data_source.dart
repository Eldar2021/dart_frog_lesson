import 'package:todo_api/models/todo/todo.dart';
import 'package:todo_api/source/source.dart';
import 'package:uuid/uuid.dart';

class TodosDataSource implements TodosDataSourceInterface {
  final _cache = <String, Todo>{};

  @override
  Future<Todo> createTodo(Todo todo) async {
    final id = const Uuid().v4();
    final createdTodo = todo.copyWith(id: id);
    _cache[id] = createdTodo;
    return createdTodo;
  }

  @override
  Future<void> deleteTodo(String id) async {
    _cache.remove(id);
  }

  @override
  Future<void> deleteTodos() async {
    _cache.clear();
  }

  @override
  Future<Todo?> getTodo(String id) async {
    return _cache[id];
  }

  @override
  Future<List<Todo>> getTodos() async {
    return _cache.values.toList();
  }

  @override
  Future<Todo> updateTodo(String id, Todo todo) async {
    final updatedTodo = _cache.update(id, (value) => todo);
    return updatedTodo.copyWith(id: id);
  }
}

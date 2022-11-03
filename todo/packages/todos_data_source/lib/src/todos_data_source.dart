// ignore_for_file: public_member_api_docs

import 'package:todos_data_source/todos_data_source.dart';
import 'package:uuid/uuid.dart';

/// An interface for a todos data source.
/// A todos data source supports basic C.R.U.D operations.
/// * C - Create
/// * R - Read
/// * U - Update
/// * D - Delete

abstract class TodosDataSource {
  Future<Todo> create(Todo todo);

  Future<List<Todo>> readAll();

  Future<Todo?> read(String id);

  Future<Todo> update(String id, Todo todo);

  Future<void> delete(String id);
}

class TodosDataSourceImpl implements TodosDataSource {
  final _cache = <String, Todo>{};

  @override
  Future<Todo> create(Todo todo) async {
    final id = const Uuid().v4();
    final createTodo = todo.copyWith(id: id);
    _cache[id] = createTodo;
    return createTodo;
  }

  @override
  Future<void> delete(String id) async {
    _cache.remove(id);
  }

  @override
  Future<Todo?> read(String id) async {
    return _cache[id];
  }

  @override
  Future<List<Todo>> readAll() async {
    return _cache.values.toList();
  }

  @override
  Future<Todo> update(String id, Todo todo) async {
    final updatedTodo = _cache.update(id, (value) => todo);
    return updatedTodo;
  }
}

import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todo_api/models/models.dart';
import 'package:todo_api/source/todo/todos_data_source.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final dataSource = context.read<TodosDataSource>();
  final t = await dataSource.getTodo(id);
  if (t == null) return Response(statusCode: HttpStatus.noContent, body: 'Not');
  return switch (context.request.method) {
    HttpMethod.get => _get(context, t),
    HttpMethod.put => _put(context, id, t),
    HttpMethod.delete => _delete(context, id),
    _ => Future.value(Response(statusCode: HttpStatus.noContent))
  };
}

Future<Response> _get(RequestContext context, Todo todo) async {
  return Response.json(body: todo);
}

Future<Response> _put(RequestContext context, String id, Todo todo) async {
  final dataSource = context.read<TodosDataSource>();
  final updatedTodo = Todo.fromJson(
    await context.request.json() as Map<String, dynamic>,
  );
  final newTodo = await dataSource.updateTodo(
    id,
    todo.copyWith(
      title: updatedTodo.title,
      description: updatedTodo.description,
      isCompleted: updatedTodo.isCompleted,
    ),
  );
  return Response.json(body: newTodo);
}

Future<Response> _delete(RequestContext context, String id) async {
  final dataSource = context.read<TodosDataSource>();
  await dataSource.deleteTodo(id);
  return Response(statusCode: HttpStatus.noContent);
}

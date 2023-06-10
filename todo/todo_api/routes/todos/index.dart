import 'dart:async';
import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:todo_api/models/todo/todo.dart';
import 'package:todo_api/source/todo/todos_data_source.dart';

FutureOr<Response> onRequest(RequestContext context) async {
  return switch (context.request.method) {
    HttpMethod.get => _get(context),
    HttpMethod.post => _post(context),
    HttpMethod.delete => _delete(context),
    _ => Future.value(Response(statusCode: HttpStatus.methodNotAllowed)),
  };
}

Future<Response> _get(RequestContext context) async {
  final dataSource = context.read<TodosDataSource>();
  final todos = await dataSource.getTodos();
  return Response.json(body: todos);
}

Future<Response> _post(RequestContext context) async {
  final dataSource = context.read<TodosDataSource>();
  final todo = Todo.fromJson(
    await context.request.json() as Map<String, dynamic>,
  );
  return Response.json(
    statusCode: HttpStatus.created,
    body: await dataSource.createTodo(todo),
  );
}

Future<Response> _delete(RequestContext context) async {
  final dataSource = context.read<TodosDataSource>();
  await dataSource.deleteTodos();
  return Response(statusCode: HttpStatus.noContent);
}

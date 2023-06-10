import 'package:dart_frog/dart_frog.dart';
import 'package:todo_api/source/todo/todos_data_source.dart';

final _dataSource = TodosDataSource();

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
        provider<TodosDataSource>((context) => _dataSource),
      );
}

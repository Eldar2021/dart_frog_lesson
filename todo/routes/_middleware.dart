import 'package:dart_frog/dart_frog.dart';
import 'package:todos_data_source/todos_data_source.dart';

final _dataSource = TodosDataSourceImpl();

Handler middleware(Handler handler) {
  return handler.use(requestLogger()).use(
        provider<TodosDataSource>((v) => _dataSource),
      );
}

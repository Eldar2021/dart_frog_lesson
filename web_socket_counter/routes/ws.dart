import 'dart:developer';

import 'package:dart_frog/dart_frog.dart';
import 'package:dart_frog_web_socket/dart_frog_web_socket.dart';
import 'package:web_socket_counter/counter_cubit.dart';

Future<Response> onRequest(RequestContext context) async {
  final handler = webSocketHandler(
    (channel, protocol) {
      final cubit = context.read<CounterCubit>()..subscribe(channel);
      channel.sink.add('${cubit.state}');

      channel.stream.listen(
        (event) {
          return switch (event) {
            '__increment__' => cubit.increment(),
            '__decrement__' => cubit.decrement(),
            _ => log('null'),
          };
        },
        onDone: () => log('disconnected'),
      );
    },
  );

  return handler(context);
}

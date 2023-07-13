import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  // Connect to the remote WebSocket endpoint.
  final uri = Uri.parse('ws://localhost:8080/ws');
  final channel = WebSocketChannel.connect(uri);

  // Listen to messages from the server.
  channel.stream.listen(print);

  channel.sink.add('__increment__');
  channel.sink.add('__decrement__');

  // Close the connection.
  channel.sink.close();
}

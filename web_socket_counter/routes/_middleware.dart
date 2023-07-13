// ignore_for_file: public_member_api_docs

import 'package:dart_frog/dart_frog.dart';
import 'package:web_socket_counter/counter_cubit.dart';

Handler middleware(Handler handler) => handler.use(counterProvider);
